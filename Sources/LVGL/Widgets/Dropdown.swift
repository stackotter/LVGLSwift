//
// Copyright (c) 2023 PADL Software Pty Ltd
//
// Licensed under the Apache License, Version 2.0 (the License);
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an 'AS IS' BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import CLVGL

public class LVDropdown: LVObject {
    public let list: LVObject
    
    public init(with parent: LVObject) {
        let object = lv_dropdown_create(parent.object)!
        self.list = LVObject(lv_dropdown_get_list(object))
        super.init(object)
    }
    
    public var text: String {
        get {
            String(cString: lv_dropdown_get_text(object), encoding: .utf8)!
        }
        set {
            withUnsafePointer(to: newValue.cString(using: .utf8)!) {
                lv_dropdown_set_text(object, $0)
            }
        }
    }
    
    public var options: String {
        get {
            String(cString: lv_dropdown_get_options(object), encoding: .utf8)!
        }
        set {
            withUnsafePointer(to: newValue.cString(using: .utf8)!) {
                lv_dropdown_set_options(object, $0)
            }
        }
    }
    
    public func add(option: String, at position: UInt32) {
        withUnsafePointer(to: option.cString(using: .utf8)!) {
            lv_dropdown_add_option(object, $0, position)
        }
    }
    
    public func clearOptions() {
        lv_dropdown_clear_options(object)
    }

    public var selected: UInt16 {
        get {
            lv_dropdown_get_selected(object)
        }
        set {
            lv_dropdown_set_selected(object, newValue)
        }
    }
    
    public var direction: lv_dir_t {
        get {
            lv_dropdown_get_dir(object)
        }
        set {
            lv_dropdown_set_dir(object, newValue)
        }
    }
    
    public var symbol: String {
        get {
            String(cString: lv_dropdown_get_symbol(object), encoding: .utf8)!
        }
        set {
            withUnsafePointer(to: newValue.cString(using: .utf8)!) {
                lv_dropdown_set_symbol(object, $0)
            }
        }
    }
    
    public var isHighlighted: Bool {
        get {
            lv_dropdown_get_selected_highlight(object)
        }
        set {
            lv_dropdown_set_selected_highlight(object, newValue)
        }
    }
    
    public func index(of option: String) -> Int32 {
        withUnsafePointer(to: options.cString(using: .utf8)!) {
            lv_dropdown_get_option_index(object, $0)
        }
    }
    
    public func open() {
        lv_dropdown_open(object)
    }
    
    public func close() {
        lv_dropdown_close(object)
    }
    
    public var isOpen: Bool {
        get {
            lv_dropdown_is_open(object)
        }
        set {
            if newValue {
                open()
            } else {
                close()
            }
        }
    }
}
