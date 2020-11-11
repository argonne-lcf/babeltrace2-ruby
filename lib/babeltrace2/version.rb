module Babeltrace2

  attach_function :bt_version_get_major,
                  [],
                  :uint

  attach_function :bt_version_get_minor,
                  [],
                  :uint

  attach_function :bt_version_get_patch,
                  [],
                  :uint

  attach_function :bt_version_get_development_stage,
                  [],
                  :string

  attach_function :bt_version_get_vcs_revision_description,
                  [],
                  :string

  attach_function :bt_version_get_name,
                  [],
                  :string

  attach_function :bt_version_get_name_description,
                  [],
                  :string

  attach_function :bt_version_get_extra_name,
                  [],
                  :string

  attach_function :bt_version_get_extra_description,
                  [],
                  :string

  attach_function :bt_version_get_extra_patch_names,
                  [],
                  :string

  module BTVersion
    class Number
      include Comparable
      attr_reader :major, :minor, :patch, :extra
      def initialize(major, minor, patch, extra = nil)
        @major = major
        @minor = minor
        @patch = patch
        @extra = extra
      end

      def to_s
        str = "#{@major}.#{@minor}.#{@patch}"
        str << " (#{extra})" if extra
        str
      end

      def to_a
        [@major, @minor, @patch]
      end

      def <=>(other)
        to_a <=> other.to_a
      end
    end

    class << self
      def get_major
        Babeltrace2.bt_version_get_major
      end
      alias major get_major

      def get_minor
        Babeltrace2.bt_version_get_minor
      end
      alias minor get_minor

      def get_patch
        Babeltrace2.bt_version_get_patch
      end
      alias patch get_patch

      def get_development_stage
        Babeltrace2.bt_version_get_development_stage
      end
      alias development_stage get_development_stage

      def get_vcs_revision_description
        Babeltrace2.bt_version_get_vcs_revision_description
      end
      alias vcs_revision_description get_vcs_revision_description

      def get_name
        Babeltrace2.bt_version_get_name
      end
      alias name get_name

      def get_name_description
        Babeltrace2.bt_version_get_name_description
      end
      alias name_description get_name_description

      def get_extra_name
        Babeltrace2.bt_version_get_extra_name
      end
      alias extra_name get_extra_name

      def get_extra_description
        Babeltrace2.bt_version_get_extra_description
      end
      alias extra_description get_extra_description

      def get_extra_patch_names
        Babeltrace2.bt_version_get_extra_patch_names
      end
      alias extra_patch_names get_extra_patch_names

      def get_number
        @number ||= Number.new(major, minor, patch)
      end
      alias number get_number
    end
  end
end
