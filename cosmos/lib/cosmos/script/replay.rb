# encoding: ascii-8bit

# Copyright 2021 Ball Aerospace & Technologies Corp.
# All Rights Reserved.
#
# This program is free software; you can modify and/or redistribute it
# under the terms of the GNU Affero General Public License
# as published by the Free Software Foundation; version 3 with
# attribution addendums as found in the LICENSE.txt
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# This program may also be used under the terms of a commercial or
# enterprise edition license of COSMOS if purchased from the
# copyright holder

module Cosmos

  module Script
    private
    def replay_select_file(filename, packet_log_reader = "DEFAULT")
      $cmd_tlm_server.replay_select_file(filename, packet_log_reader)
    end

    def replay_status
      $cmd_tlm_server.replay_status
    end

    def replay_set_playback_delay(delay)
      $cmd_tlm_server.replay_set_playback_delay(delay)
    end

    def replay_play
      $cmd_tlm_server.replay_play
    end

    def replay_reverse_play
      $cmd_tlm_server.replay_reverse_play
    end

    def replay_stop
      $cmd_tlm_server.replay_stop
    end

    def replay_step_forward
      $cmd_tlm_server.replay_step_forward
    end

    def replay_step_back
      $cmd_tlm_server.replay_step_back
    end

    def replay_move_start
      $cmd_tlm_server.replay_move_start
    end

    def replay_move_end
      $cmd_tlm_server.replay_move_end
    end

    def replay_move_index(index)
      $cmd_tlm_server.replay_move_index(index)
    end
  end
end
