# 提供一些VIM扩展
module V
  def self.feedkeys(keys, mode = "m", escape: true, throw: false)
    keys = VIM.replace_termcodes(keys, true, false, true) if escape
    VIM.command('let v:errmsg = ""') if throw
    VIM.feedkeys(keys, mode, false)
    if throw and m = VIM.eval('v:errmsg') and m != ""
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
end
