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

public class LVScreen: LVObject {
    public init() {
        super.init(lv_obj_create(nil))
    }
    
    static var current: LVScreen? {
        let screen = lv_scr_act()
        
        guard let userData = screen?.pointee.user_data else {
            return nil
        }
        
        return bridgeToSwift(userData)
    }
    
    func load() {
        lv_scr_load(object)
    }

}