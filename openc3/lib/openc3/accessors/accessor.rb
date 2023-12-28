# encoding: ascii-8bit

# Copyright 2023 OpenC3, Inc.
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
# This file may also be used under the terms of a commercial license
# if purchased from OpenC3, Inc.

require 'json'

module OpenC3
  class Accessor
    attr_accessor :packet

    def initialize(packet = nil)
      @packet = packet
      @args = []
    end

    def read_item(item, buffer)
      self.class.read_item(item, buffer)
    end

    def write_item(item, value, buffer)
      self.class.write_item(item, value, buffer)
    end

    def read_items(items, buffer)
      result = {}
      items.each do |item|
        result[item.name] = read_item(item, buffer)
      end
      return result
    end

    def write_items(items, values, buffer)
      items.each_with_index do |item, index|
        write_item(item, values[index], buffer)
      end
      return values
    end

    def args
      return @args
    end

    def enforce_encoding
      return 'ASCII-8BIT'.freeze
    end

    def enforce_length
      return true
    end

    def enforce_short_buffer_allowed
      return false
    end

    def enforce_derived_write_conversion(item)
      return true
    end

    def self.read_item(item, buffer)
      raise "Must be defined by subclass"
    end

    def self.write_item(item, value, buffer)
      raise "Must be defined by subclass"
    end

    def self.read_items(items, buffer)
      result = {}
      items.each do |item|
        result[item.name] = read_item(item, buffer)
      end
      return result
    end

    def self.write_items(items, values, buffer)
      items.each_with_index do |item, index|
        write_item(item, values[index], buffer)
      end
      return values
    end

    def self.convert_to_type(value, item)
      case item.data_type
      when :OBJECT
        # Do nothing for complex object types
      when :STRING, :BLOCK
        if item.array_size
          value = JSON.parse(value) if value.is_a? String
          value = value.map(&:to_s)
        else
          value = value.to_s
        end
      when :UINT, :INT
        if item.array_size
          value = JSON.parse(value) if value.is_a? String
          value = value.map(&:to_i)
        else
          value = value.to_i
        end
      when :FLOAT
        if item.array_size
          value = JSON.parse(value) if value.is_a? String
          value = value.map(&:to_f)
        else
          value = value.to_f
        end
      else
        raise(ArgumentError, "data_type #{item.data_type} is not recognized")
      end
      return value
    end
  end
end
