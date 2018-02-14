ROOT_PATH = File.dirname(__FILE__)

Dir.glob(File.expand_path('lib/**/*.rb', ROOT_PATH), &method(:require))

include Dotfiles

task install: ['dotfiles:install']

namespace :dotfiles do

  task :install do
    newline
    system('sudo -v')

    tasks = %w/zsh python ruby symlinks macos_defaults config_files homebrew atom/
    tasks.each do |t|
      Rake::Task["dotfiles:#{t}"].invoke
      newline
    end
  end

  task :zsh do
    Dotfiles::Zsh.run
  end

  task :python do
    Dotfiles::Python.run
  end

  task :ruby do
    Dotfiles::Ruby.run
  end

  task :symlinks do
    Dotfiles::Symlinks.run
  end

  task :macos_defaults do
    Dotfiles::MacosDefaults.run
  end

  task :config_files do
    Dotfiles::ConfigFiles.run
  end

  task :homebrew do
    Dotfiles::Homebrew.run
  end

  task :atom do
    Dotfiles::Atom.run
  end

  task :update_atom_icon do
    Dotfiles::Atom.update_icon
  end

end
