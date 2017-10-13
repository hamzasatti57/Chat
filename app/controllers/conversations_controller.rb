class ConversationsController < ApplicationController
  def create
    @conversation = Conversation.get(current_user.id, params[:user_id])

    add_to_conversations unless conversated?

    respond_to do |format|
      format.js
    end
  end

def self.get_or_create(sender_id, recipient_id)
return unless sender_and_recipient_exist?(sender_id, recipient_id)
conversation = between(sender_id, recipient_id).first
return conversation if conversation.present?

create(sender_id: sender_id, recipient_id: recipient_id)
end

def self.sender_and_recipient_exist?(sender_id, recipient_id)
User.where(id: sender_id).exists? && User.where(id: recipient_id).exists?
end

  def close
    @conversation = Conversation.find(params[:id])

    session[:conversations].delete(@conversation.id)

    respond_to do |format|
      format.js
    end
  end

  private

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end
end
