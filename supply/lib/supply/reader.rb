module Supply
  class Reader
    def track_version_codes
      track = Supply.config[:track]

      client.begin_edit(package_name: Supply.config[:package_name])
      version_codes = client.track_version_codes(track)
      client.abort_current_edit

      if version_codes.empty?
        UI.important("No version codes found in track '#{track}'")
      else
        UI.success("Found '#{version_codes.join(', ')}' version codes in track '#{track}'")
      end

      version_codes
    end

    def track_release_names
      track = Supply.config[:track]

      client.begin_edit(package_name: Supply.config[:package_name])
      release_names = client.track_releases(track).map(&:name)
      client.abort_current_edit

      if release_names.empty?
        UI.important("No release names found in track '#{track}'")
      else
        UI.success("Found '#{release_names.join(', ')}' release names in track '#{track}'")
      end

      release_names
    end

    def aab_version_codes
      package_name = Supply.config[:package_name]
      client.begin_edit(package_name: package_name)
      version_codes = client.aab_version_codes
      client.abort_current_edit

      if version_codes.empty?
        UI.important("No version codes found in aab '#{package_name}'")
      else
        UI.success("Found '#{version_codes.join(', ')}' version codes in aab '#{package_name}'")
      end

      version_codes
    end

    private

    def client
      @client ||= Client.make_from_config
    end
  end
end
