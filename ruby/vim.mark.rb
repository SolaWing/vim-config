raise "this only as annotation for solargraph, shouldn't require!"

require "neovim"
module VIM
  extend ::Neovim::Client
  class Buffer < Neovim::Buffer; end
  class Window < Neovim::Window; end
end

# @!override Neovim::Buffer.current
#  @return [Neovim::Buffer]
# @!override Neovim::Buffer.[]
#  @return [Neovim::Buffer]

# @!override Neovim::Window.current
#  @return [Neovim::Window]
# @!override Neovim::Window.[]
#  @return [Neovim::Window]
