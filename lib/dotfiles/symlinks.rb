require 'time'

module Dotfiles
  class Symlinks

    def self.run
      message('Symlinks:'.bold, indent: 0)
      dir = Dir["#{ROOT_PATH}/homedir/{\.?}**/*.symlink"] +
            Dir["#{ROOT_PATH}/homedir/**/*.symlink"]


      max_width = dir.map { |fs_item| file_basename(fs_item).length }.max

      dir.each do |fs_item|
        create_symlink(fs_item, max_width)
      end
    end

    private

      def self.create_symlink(file, max_width=0)
        basename = file_basename(file)
        source   = File.expand_path(file, ROOT_PATH)
        target   = File.expand_path("~/#{file_basename(file).gsub('.symlink', '')}")

        if File.exist?(source)
          if File.symlink?(target)
            symlink_to = File.readlink(target)

            if symlink_to == source
              message_part = "[Skipped] #{target} exists".red
            else
              message_part = "[Re-created] #{target}".green

              FileUtils.rm(target)
              FileUtils.ln_s(source, target)
            end
          elsif File.exist?(target)
            backup       = File.join(ROOT_PATH, 'backups', "#{File.basename(target)}.#{Time.now.strftime('%Y%m%d%H%M%S')}_backup")
            message_part = "[Overwritten] #{target}".red

            FileUtils.mv(target, backup)
            FileUtils.ln_s(source, target)
          else
            message_part = "[Created] #{target}".green

            FileUtils.ln_s(source, target)
          end
        else
          message_part = "[Source Missing] #{source}".red
        end

        message(("%-#{max_width}s %s" % [basename, message_part]), indent: 2)
      end

  end
end
