class Private::ConversationChannel < ApplicationCable::Channel
  # subscribed means a user opens a connection
  def subscribed
    # stream_from "some_channel"
    stream_from "private_conversations_#{current_user.id}"
  end

  # unsubscribed means a user closes a connection
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  def send_message(data)
    message_params = data['message'].each_with_object({}) do |el, hash|
      hash[el['name']] = el['value']
    end
    Private::Message.create(message_params)
  end

  def set_as_seen(data)
    # find a conversation and set its all unseen messages as seen
    conversation = Private::Conversation.find(data['conv_id'].to_i)
    messages = conversation.messages.where(seen: false)
    messages.each do |message|
      message.update(seen: true)
    end
  end
end