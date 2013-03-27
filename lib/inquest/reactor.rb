class Inquest::Reactor
  def self.react!(user, notifiable, action)
    raise NotYetImplementedError
  end

  def self.reaction_description
    raise NotYetImplementedError
  end
end