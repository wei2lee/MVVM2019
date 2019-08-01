//
//  Math.swift
//  theera
//
//  Created by lee yee chuan on 4/9/17.
//  Copyright © 2017 infradesign. All rights reserved.
//

import Foundation
import UIKit
struct LerpFloat {
    var to:Float = 0
    var damp:Float = 0
    var value:Float = 0
    var snap:Float = 0.01
    mutating func update(elapsed:TimeInterval) {
        var newValue = lerp(damp * Float(elapsed), value, to, true)
        if (value <= newValue && newValue <= to) || (to <= newValue && newValue <= value) {
            if abs(newValue - to) <= snap {
                newValue = to
            }
        }
        value = newValue
    }
}

struct LerpCGFloat {
    var to:CGFloat = 0
    var damp:CGFloat = 0
    var value:CGFloat = 0
    var snap:CGFloat = 0.01
    mutating func update(elapsed:TimeInterval) {
        var newValue = lerp(damp * CGFloat(elapsed), value, to, true)
        if (value <= newValue && newValue <= to) || (to <= newValue && newValue <= value) {
            if abs(newValue - to) <= snap {
                newValue = to
            }
        }
        value = newValue
        
    }
}

struct LerpDouble {
    var to:Double = 0
    var damp:Double = 0
    var value:Double = 0
    var snap:Double = 0.01
    mutating func update(elapsed:TimeInterval) {
        var newValue = lerp(damp * Double(elapsed), value, to, true)
        if (value <= newValue && newValue <= to) || (to <= newValue && newValue <= value) {
            if abs(newValue - to) <= snap {
                newValue = to
            }
        }
        value = newValue
        
    }
}

func clamp(_ val:Double, _ minval:Double, _ maxval:Double) -> Double {
    if minval < maxval {
        return min(max(val, minval), maxval)
    } else {
        return min(max(val, maxval), minval)
    }
}

func clamp(_ val:CGFloat, _ minval:CGFloat, _ maxval:CGFloat) -> CGFloat {
    if minval < maxval {
        return min(max(val, minval), maxval)
    } else {
        return min(max(val, maxval), minval)
    }
}

func clamp(_ val:Float, _ minval:Float, _ maxval:Float) -> Float {
    if minval < maxval {
        return min(max(val, minval), maxval)
    } else {
        return min(max(val, maxval), minval)
    }
}

func clamp(_ val:Int, _ minval:Int, _ maxval:Int) -> Int {
    if minval < maxval {
        var t:Int = val
        if t < minval {
            t = minval
        }
        if t > maxval {
            t = maxval
        }
        return t
    } else {
        var t:Int = val
        if t < maxval {
            t = maxval
        }
        if t > minval {
            t = minval
        }
        return t
    }
}

func lerp(_ damp:CGFloat, _ min:CGFloat, _ max:CGFloat, _ bound:Bool = false) -> CGFloat {
    
    if min == max {
        return min
    } else {
        var _damp = damp
        if bound {
            _damp = clamp(_damp, 0, 1)
        }
        let ret = (max - min) * _damp + min
        return ret
    }
}

func lerp(_ damp:Float, _ min:Float, _ max:Float, _ bound:Bool = false) -> Float {
    
    if min == max {
        return min
    } else {
        var _damp = damp
        if bound {
            _damp = clamp(_damp, 0, 1)
        }
        let ret = (max - min) * _damp + min
        return ret
    }
}

func lerp(_ damp:Double, _ min:Double, _ max:Double, _ bound:Bool = false) -> Double {
    
    if min == max {
        return min
    } else {
        var _damp = damp
        if bound {
            _damp = clamp(_damp, 0, 1)
        }
        let ret = (max - min) * _damp + min
        return ret
    }
}

typealias ColorComponent = (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat)

func lerpColor(_ damp:CGFloat, _ from:UIColor, _ to:UIColor) -> UIColor {
    var ret:UIColor!
    
    var fromComponenets:ColorComponent = ColorComponent(r:0, g:0, b:0, a:0)
    from.getRed(&fromComponenets.r, green: &fromComponenets.g, blue: &fromComponenets.b, alpha: &fromComponenets.a)
    var toComponenets:ColorComponent = ColorComponent(r:0, g:0, b:0, a:0)
    to.getRed(&toComponenets.r, green: &toComponenets.g, blue: &toComponenets.b, alpha: &toComponenets.a)
    
    var componenets:ColorComponent = ColorComponent(r:0, g:0, b:0, a:0)
    componenets.r = lerp(damp, fromComponenets.r, toComponenets.r)
    componenets.g = lerp(damp, fromComponenets.g, toComponenets.g)
    componenets.b = lerp(damp, fromComponenets.b, toComponenets.b)
    componenets.a = lerp(damp, fromComponenets.a, toComponenets.a)
    
    ret = UIColor(red: componenets.r, green: componenets.g, blue: componenets.b, alpha: componenets.a)
    return ret
}

func inverseLerp(_ val:Double, _ min:Double, _ max:Double, _ bound:Bool = false) -> Double {
    if min == max {
        return 0
    } else {
        var ret = (val - min) / (max - min)
        if bound {
            ret = clamp(ret, 0, 1)
        }
        return ret
    }
}

func inverseLerp(_ val:Float, _ min:Float, _ max:Float, _ bound:Bool = false) -> Float {
    if min == max {
        return 0
    } else {
        var ret = (val - min) / (max - min)
        if bound {
            ret = clamp(ret, 0, 1)
        }
        return ret
    }
}

func inverseLerp(_ val:CGFloat, _ min:CGFloat, _ max:CGFloat, _ bound:Bool = false) -> CGFloat {
    if min == max {
        return 0
    } else {
        var ret = (val - min) / (max - min)
        if bound {
            ret = clamp(ret, 0, 1)
        }
        return ret
    }
}
