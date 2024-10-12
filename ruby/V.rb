# 提供一些VIM扩展
module V
  def self.feedkeys!(*, **) = feedkeys(*, **, throw: false)
  def self.feedkeys(keys, mode = "m", escape: true, throw: true)
    keys = VIM.replace_termcodes(keys, true, true, true) if escape
    VIM.command('let v:errmsg = ""') if throw
    if throw
      check { VIM.feedkeys(keys, mode, false) }
    else
      VIM.feedkeys(keys, mode, false)
    end
  end
  def self.check
    VIM.command('let v:errmsg = ""')
    yield
    if m = VIM.eval('v:errmsg') and m != ""
      raise "vim error: #{m}"
    end
  end
  # VIM expr true
  def self.true?(value)
    case value
    when 0 then false
    else !!value
    end
  end
  def self.selected_text = VIM.eval "GetVisualString()"
end
