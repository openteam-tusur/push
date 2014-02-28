class CheckSecret
  def incoming(message, callback)
    if message['ext'] && message['ext']['secret'] != ENV['SECRET']
      message['error'] = 'Invalid authentication token'
    end

    callback.call(message)
  end

  def outgoing(message, callback)
    if message['ext'] && message['ext']['secret']
      message['ext'] = {}
    end
    callback.call(message)
  end
end
