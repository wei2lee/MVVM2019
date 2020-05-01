//
//  FlowLayout.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 03/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

@objc protocol PinterestFlowLayoutDelegate: class {
    func collectionView(heightForCellAtIndexPath indexPath:IndexPath, withWidth width: CGFloat) -> CGFloat
    @objc optional func collectionView(estimatedHeightForCellAtIndexPath indexPath:IndexPath, withWidth width: CGFloat) -> CGFloat
}

class PinterestFlowLayout: UICollectionViewFlowLayout {
    typealias AttributesResult = (attributes: [Int: [IndexPath: PinterestLayoutAttributes]], contentSize: CGSize)
    fileprivate var prepared: Bool = false
    fileprivate var sectionAttributesCache: [Int: [IndexPath: PinterestLayoutAttributes]] = [Int: [IndexPath: PinterestLayoutAttributes]]()
    fileprivate var attributesCache = [IndexPath: PinterestLayoutAttributes]()
    fileprivate var supplementaryCache = [IndexPath: UICollectionViewLayoutAttributes]()
    
    fileprivate var contentSize = CGSize.zero
    private var numberOfColumns = 1
    private var cellLeftRightPadding: CGFloat = 0
    private var cellTopBottomPadding: CGFloat = 0
    private var shouldInvalidateDuringScrolling: Bool = false
    private var updateIsScrollingTimer: Timer? = nil
    weak var delegate: PinterestFlowLayoutDelegate?
    var contentSizeRelay = BehaviorRelay<CGSize>(value: .zero)
    var estimateItemHeight: CGFloat = 223
    var headerHeight: CGFloat = 0
    
    fileprivate var cacheHeight = [Int: CGFloat]()
    
    var isScrolling: Bool = false {
        didSet {
            guard let collectionView = collectionView else { return }
            if !isScrolling {
                let context = PinterestLayoutInvalidationContext()
                context.boundOriginChanged = true
                context.invalidatedBounds = collectionView.bounds
                invalidateLayout(with: context)
            }
        }
    }
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    init(delegate: PinterestFlowLayoutDelegate, numberOfColumns: Int, cellLeftRightPadding: CGFloat, cellTopBottomPadding: CGFloat) {
        super.init()
        self.delegate = delegate
        self.numberOfColumns = numberOfColumns
        self.cellLeftRightPadding = cellLeftRightPadding
        self.cellTopBottomPadding = cellTopBottomPadding
    }
    
    deinit {
        self.updateIsScrollingTimer?.invalidate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentSize.width, height: contentSize.height + headerHeight)
    }
    
    override class var invalidationContextClass: AnyClass { return PinterestLayoutInvalidationContext.self }
    
    override class var layoutAttributesClass: AnyClass { return PinterestLayoutAttributes.self }
    
    override func prepare() {
        guard !prepared else { return }
        prepared = true
        guard let collectionView = self.collectionView else { return }
        self.setupTimerUpdateIsScrolling()
        let (attributes, contentSize) = createLayout(isEstimateItemHeight: true)
        self.contentSize = contentSize
        self.sectionAttributesCache = attributes
        
        let (attributes2, contentSize2) = createLayout(isEstimateItemHeight: false, attributesCache: self.sectionAttributesCache, visibleBounds: collectionView.bounds)
        self.contentSize = contentSize2
        self.sectionAttributesCache = attributes2
        
        let (attributes3, contentSize3) = createAdjustedLayoutOriginY(attributesCache: sectionAttributesCache)
        self.contentSize = contentSize3
        self.contentSizeRelay.accept(contentSize3)
        self.sectionAttributesCache = attributes3
    }
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        for updateItem in updateItems {
            //print("updateItem = \(updateItem)")
            switch updateItem.updateAction {
            case .insert:
                if updateItems.count != collectionView!.numberOfItems(inSection: updateItem.indexPathAfterUpdate!.section) {
                    let (attributes, contentSize) = insertLayout(isEstimateItemHeight: true, attributesCache: sectionAttributesCache, indexPath: updateItem.indexPathAfterUpdate!)
                    self.contentSize = contentSize
                    self.sectionAttributesCache = attributes
                } else {
                    let (attributes, contentSize) = createLayout(isEstimateItemHeight: true)
                    self.contentSize = contentSize
                    self.sectionAttributesCache = attributes
                }
                break
            case .delete:
                if collectionView != nil && updateItems.count < collectionView!.numberOfItems(inSection: updateItem.indexPathBeforeUpdate!.section) {
                    let (attributes, contentSize) = insertLayout(isEstimateItemHeight: true, attributesCache: sectionAttributesCache, indexPath: updateItem.indexPathBeforeUpdate!)
                    self.contentSize = contentSize
                    self.sectionAttributesCache = attributes
                } else {
                    let (attributes, contentSize) = createLayout(isEstimateItemHeight: true)
                    self.contentSize = contentSize
                    self.sectionAttributesCache = attributes
                }
                break
            case .move:
                break
            case .reload:
                break
            case .none:
                break
            @unknown default:
                break
            }
        }
        
        let (attributes2, contentSize2) = createLayout(isEstimateItemHeight: false, attributesCache: self.sectionAttributesCache, visibleBounds: collectionView!.bounds)
        self.contentSize = contentSize2
        self.sectionAttributesCache = attributes2
        
        let (attributes3, contentSize3) = createAdjustedLayoutOriginY(attributesCache: sectionAttributesCache)
        self.contentSize = contentSize3
        self.contentSizeRelay.accept(contentSize3)
        self.sectionAttributesCache = attributes3
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // Get section header view
        guard let collectionView = self.collectionView, collectionView.numberOfSections > 0 else { return nil }
        
        if sectionAttributesCache[0]!.count != collectionView.numberOfItems(inSection: 0) || collectionView.numberOfItems(inSection: 0) <= 0 {
            return [UICollectionViewLayoutAttributes]()
        }
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        sectionAttributesCache.values.forEach { items in
            items.values.filter{ $0.frame.intersects(rect) }.forEach {
                visibleLayoutAttributes.append($0)
            }
        }
        
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else { return visibleLayoutAttributes }
        
        let sectionsToAdd = NSMutableIndexSet()
        for layoutAttributesSet in layoutAttributes {
            if layoutAttributesSet.representedElementCategory == .supplementaryView {
                sectionsToAdd.add(layoutAttributesSet.indexPath.section)
            }
        }
        
        for section in sectionsToAdd {
            let indexPath = IndexPath(item: 0, section: section)
            if let sectionAttributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath) {
                visibleLayoutAttributes.append(sectionAttributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return sectionAttributesCache[indexPath.section]![indexPath]
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let layoutAttributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) else { return nil }
        guard let boundaries = boundaries(forSection: indexPath.section) else { return layoutAttributes }
        
        var frameForSupplementaryView = layoutAttributes.frame
        frameForSupplementaryView.origin.y = boundaries
        
        layoutAttributes.frame = frameForSupplementaryView
        supplementaryCache[indexPath] = layoutAttributes
        return layoutAttributes
    }
    
    func boundaries(forSection section: Int) -> CGFloat? {
        let result = CGFloat(0.0)
        guard collectionView != nil else { return result }
        guard section > 0 else { return result }
        
        var maxSectionHeight: CGFloat = 0
        sectionAttributesCache[section - 1]?.values.forEach {
            maxSectionHeight = max(maxSectionHeight, $0.frame.maxY)
        }
        return maxSectionHeight + cellTopBottomPadding
    }
    
    func createLayout(isEstimateItemHeight: Bool) -> AttributesResult {
        guard let collectionView = self.collectionView else { return (contentSize: .zero, attributes: [:]) }
        var contentSize: CGSize = .zero
        var defaultYOffset: CGFloat = 0
        var maxYOffset: CGFloat = 0
        
        for i in 0..<collectionView.numberOfSections {
            var yoffset:[Int: CGFloat] = [:]
            var attributesCache: [IndexPath: PinterestLayoutAttributes] = [:]
            defaultYOffset = maxYOffset + headerHeight
            if i != 0 {
                defaultYOffset += cellTopBottomPadding
            }
            
            for _j in 0..<collectionView.numberOfItems(inSection: i) {
                let j = _j % numberOfColumns
                let indexPath = IndexPath(item: _j, section: i)
                let attributes = createAttribute(isEstimateItemHeight: isEstimateItemHeight,
                                                 columnIndex: j,
                                                 yoffset: yoffset[j] ?? defaultYOffset,
                                                 indexPath: indexPath)
                attributesCache[indexPath] = attributes
                contentSize.height = max(attributes.frame.maxY, contentSize.height)
                
                yoffset[j] = CGFloat(attributes.frame.maxY)
                maxYOffset = max(defaultYOffset, attributes.frame.maxY)
                //print("estimate \(indexPath.section)", attributes.frame)
            }
            sectionAttributesCache[i] = attributesCache
        }
        contentSize.width = collectionView.bounds.width - (2 * cellLeftRightPadding)
        return (contentSize: contentSize, attributes: sectionAttributesCache)
    }
    
    func createLayout(isEstimateItemHeight: Bool, attributesCache: [Int: [IndexPath: PinterestLayoutAttributes]], visibleBounds: CGRect) -> (attributes: [Int: [IndexPath: PinterestLayoutAttributes]], contentSize: CGSize) {
        let attributesInBounds = sectionAttributesCache.values.map {
            $0.values.filter { att in
                return visibleBounds.intersects(att.frame)
            }
        }
        
        var sectionRet: [Int: [IndexPath: PinterestLayoutAttributes]] = sectionAttributesCache
        for attributesInBound in attributesInBounds {
            let estimatedAttributes = attributesInBound.filter {$0.isEstimatedItemSize}
            if estimatedAttributes.count > 0 {
                _ = estimatedAttributes.map { $0.indexPath }
                for attributes in estimatedAttributes {
                    let indexPath = attributes.indexPath
                    let newAttributes = createAttribute(isEstimateItemHeight: isEstimateItemHeight,
                                                        columnIndex: attributes.columnIndex,
                                                        yoffset: attributes.frame.minY-cellTopBottomPadding,
                                                        indexPath: attributes.indexPath)
                    var ret = sectionRet[indexPath.section]!
                    ret[indexPath] = newAttributes
                    sectionRet[indexPath.section] = ret
                    //print("accurate \(indexPath.section)", newAttributes.frame)
                }
            }
        }
        return (attributes: sectionRet, contentSize: contentSize)
    }
    
    func createAdjustedLayoutOriginY(attributesCache: [Int: [IndexPath: PinterestLayoutAttributes]]) -> AttributesResult {
        var sectionRet: [Int:[IndexPath: PinterestLayoutAttributes]] = [Int: [IndexPath: PinterestLayoutAttributes]]()
        var defaultYOffset: CGFloat = 0
        var maxYOffset: CGFloat = 0
        
        for i in 0..<sectionAttributesCache.count {
            var ret: [IndexPath: PinterestLayoutAttributes] = [:]
            maxYOffset += (cellTopBottomPadding + headerHeight)
            defaultYOffset = maxYOffset
            if i != 0 {
                defaultYOffset += cellTopBottomPadding
            }
            
            let groupByColumnIndex: Dictionary<Int, [(key: IndexPath, value: PinterestLayoutAttributes)]> =
                Dictionary(grouping: attributesCache[i]!.enumerated().map { $0.element }, by: { return $0.key.item % numberOfColumns })
            for columnIndex in groupByColumnIndex.keys {
                let columnList = groupByColumnIndex[columnIndex]!
                let sortedColumnList = columnList.sorted(by: {  $0.key.item < $1.key.item })
                var yoffset: CGFloat = 0
                for (index, attr) in sortedColumnList.enumerated() {
                    let indexPath: IndexPath = attr.key
                    if index == 0 {
                        var origin = attr.value.frame.origin
                        origin.y = defaultYOffset
                        attr.value.frame.origin = origin
                        yoffset = attr.value.frame.maxY
                        ret[indexPath] = attr.value
                        //print("alignment", attr.value.frame)
                    } else {
                        var origin = attr.value.frame.origin
                        origin.y = yoffset + cellTopBottomPadding
                        attr.value.frame.origin = origin
                        yoffset = attr.value.frame.maxY
                        ret[indexPath] = attr.value
                        //print("alignment", attr.value.frame)
                    }
                }
                maxYOffset = max(maxYOffset, yoffset)
            }
            sectionRet[i] = ret
        }
        contentSize = createContentSize(attributesCache: sectionRet)
        return (attributes: sectionRet, contentSize: contentSize)
    }
    
    func insertLayout(isEstimateItemHeight: Bool, attributesCache: [Int: [IndexPath: PinterestLayoutAttributes]] , indexPath: IndexPath) -> (attributes: [Int:[IndexPath: PinterestLayoutAttributes]], contentSize: CGSize) {
        
        guard let collectionView = self.collectionView else { return (contentSize: .zero, attributes: [:]) }
        let previousIndexPath = IndexPath(item: indexPath.row - (numberOfColumns + 1), section: indexPath.section)
        
        var updatedAttributesCache: [IndexPath: PinterestLayoutAttributes] = [:]
        var updatedSectionAttributesCache: [Int: [IndexPath: PinterestLayoutAttributes]] = [Int: [IndexPath: PinterestLayoutAttributes]]()
        
        for i in 0..<indexPath.section + 1 {
            updatedAttributesCache = [:]
            for _j in 0..<indexPath.row {
                let indexPath = IndexPath(row: _j, section: indexPath.section)
                updatedAttributesCache[indexPath] = attributesCache[indexPath.section]![indexPath]
            }
            updatedSectionAttributesCache[i] = updatedAttributesCache
        }
        
        if attributesCache[indexPath.section]![indexPath] != nil {
            let previousYOffset = (indexPath.row - 1) - numberOfColumns > numberOfColumns ? attributesCache[indexPath.section]![previousIndexPath]!.frame.maxY : 0
            
            var yoffset:[Int: CGFloat] = [:]
            for i in 0..<collectionView.numberOfSections {
                updatedAttributesCache = updatedSectionAttributesCache[indexPath.section]!
                for _j in indexPath.row..<collectionView.numberOfItems(inSection: i) {
                    let j = _j % numberOfColumns
                    let indexPath = IndexPath(item: _j, section: i)
                    let attributes = createAttribute(isEstimateItemHeight: isEstimateItemHeight,
                                                     columnIndex: j,
                                                     yoffset: yoffset[j] ?? previousYOffset,
                                                     indexPath: indexPath)
                    updatedAttributesCache[indexPath] = attributes
                    contentSize.width = max(attributes.frame.maxX, contentSize.width)
                    contentSize.height = max(attributes.frame.maxY, contentSize.height)
                    yoffset[j] = CGFloat(attributes.frame.maxY)
                }
                updatedSectionAttributesCache[indexPath.section] = updatedAttributesCache
            }
            return (attributes: updatedSectionAttributesCache, contentSize: contentSize)
        } else {
            let previousYOffset = attributesCache[indexPath.section]!.count > numberOfColumns ? attributesCache[indexPath.section]![previousIndexPath]!.frame.maxY : 0
            
            var yoffset:[Int: CGFloat] = [:]
            for i in 0..<collectionView.numberOfSections {
                if updatedSectionAttributesCache.count > 0 {
                    updatedAttributesCache = updatedSectionAttributesCache[indexPath.section]!
                }
                for _j in indexPath.row..<collectionView.numberOfItems(inSection: i) {
                    let j = _j % numberOfColumns
                    let indexPath = IndexPath(item: _j, section: i)
                    let attributes = createAttribute(isEstimateItemHeight: isEstimateItemHeight,
                                                     columnIndex: j,
                                                     yoffset: yoffset[j] ?? previousYOffset,
                                                     indexPath: indexPath)
                    updatedAttributesCache[indexPath] = attributes
                    contentSize.height = max(attributes.frame.maxY, contentSize.height)
                    
                    yoffset[j] = CGFloat(attributes.frame.maxY)
                }
                updatedSectionAttributesCache[indexPath.section] = updatedAttributesCache
            }
        }
        return (attributes: updatedSectionAttributesCache, contentSize: contentSize)
    }
    
    func createAttribute(isEstimateItemHeight:Bool, columnIndex: Int, yoffset: CGFloat, indexPath: IndexPath) -> PinterestLayoutAttributes {
        let attributes = PinterestLayoutAttributes(forCellWith: indexPath)
        attributes.isEstimatedItemSize = isEstimateItemHeight
        let cellWidth:CGFloat = floor((collectionView!.bounds.width - CGFloat(numberOfColumns+1) * cellLeftRightPadding) / CGFloat(numberOfColumns))
        attributes.columnIndex = columnIndex
        attributes.frame = CGRect(x: CGFloat(columnIndex) * (cellWidth + cellLeftRightPadding) + cellLeftRightPadding,
                                  y: yoffset + cellTopBottomPadding,
                                  width: cellWidth,
                                  height: isEstimateItemHeight ? delegate?.collectionView?(estimatedHeightForCellAtIndexPath: indexPath, withWidth: cellWidth) ?? estimateItemHeight :
                                    delegate?.collectionView(heightForCellAtIndexPath: indexPath, withWidth: cellWidth) ?? estimateItemHeight)
        return attributes
    }
    
    func createContentSize(attributesCache: [Int: [IndexPath: PinterestLayoutAttributes]]) -> CGSize {
        return sectionAttributesCache.values.map {
            $0.values
                .map { $0.frame }
                .reduce(CGSize.zero, { CGSize(width: max($0.width, $1.maxX), height: max($0.height, $1.maxY)) })
            }.reduce(CGSize.zero, { CGSize(width: max($0.width, $1.width), height: max($0.height, $1.height)) })
    }
    
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        let context = context as! PinterestLayoutInvalidationContext
        if context.invalidateEverything || context.headerOriginChanged {
            prepared = false
        }
        if context.invalidatedBounds != .zero {
            let (attributes, contentSize) = createLayout(isEstimateItemHeight: false, attributesCache: self.sectionAttributesCache, visibleBounds: context.invalidatedBounds)
            self.sectionAttributesCache = attributes
            self.contentSize = contentSize
            
            let (attributes2, contentSize2) = createAdjustedLayoutOriginY(attributesCache: self.sectionAttributesCache)
            self.sectionAttributesCache = attributes2
            self.contentSize = contentSize2
            self.contentSizeRelay.accept(contentSize2)
            
            invalidateAllCachedIndexPaths(context: context)
        }
        super.invalidateLayout(with: context)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if shouldInvalidateDuringScrolling {
            return newBounds.origin != collectionView!.bounds.origin
        } else {
            return newBounds.size != collectionView!.bounds.size
        }
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let ret = super.invalidationContext(forBoundsChange: newBounds) as! PinterestLayoutInvalidationContext
        if shouldInvalidateDuringScrolling {
            if newBounds.origin != collectionView!.bounds.origin {
                ret.boundOriginChanged = true
                ret.invalidatedBounds = newBounds
            }
        }
        return ret
    }
    
    override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        let ret = super.shouldInvalidateLayout(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)
        return ret
    }
    
    override func invalidationContext(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) ->
        UICollectionViewLayoutInvalidationContext {
            let ret = super.invalidationContext(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)
            return ret
    }
    
    func invalidateAllCachedIndexPaths(context: PinterestLayoutInvalidationContext) {
        var indexPaths: [IndexPath] = []
        sectionAttributesCache.values.forEach {
            $0.keys.sorted(by: { $0.item < $1.item }).forEach {
                indexPaths.append($0)
            }
        }
        context.invalidateItems(at: indexPaths)
    }
    
    func refreshHeaderHeight(height: CGFloat) {
        self.headerHeight = height
        let context = PinterestLayoutInvalidationContext()
        context.headerOriginChanged = true
        invalidateLayout(with: context)
    }
    
    func setupTimerUpdateIsScrolling() {
        self.updateIsScrollingTimer?.invalidate()
        self.updateIsScrollingTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            guard let `self` = self else { return }
            guard let collectionView = self.collectionView else { return }
            let newValue = collectionView.isDragging || collectionView.isDecelerating
            if newValue != self.isScrolling {
                self.isScrolling = newValue
            }
        }
        RunLoop.current.add(updateIsScrollingTimer!, forMode: .common)
    }
}


class PinterestLayoutInvalidationContext: UICollectionViewFlowLayoutInvalidationContext {
    var boundOriginChanged: Bool = false
    var headerOriginChanged: Bool = false
    var invalidatedBounds: CGRect = .zero
}

class PinterestLayoutAttributes: UICollectionViewLayoutAttributes {
    var isEstimatedItemSize: Bool = false
    var columnIndex: Int = 0
}
