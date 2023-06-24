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
import CLVGLSwift

public actor LVGLSwift {
    public static let shared = LVGLSwift()

    init() {
	lv_init()
	LVGLSwiftDriverInit()

        Task.detached {
            repeat {
                try await Task.sleep(nanoseconds: 5 * 1_000_000)
                lv_tick_inc(5)
            } while !Task.isCancelled
        }
    }

    func run() {
        repeat {
            lv_task_handler()
            usleep(5000)
        } while !Task.isCancelled
    }
}
