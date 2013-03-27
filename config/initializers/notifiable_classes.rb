# Set classes that can be notified when
# actions happen to them
Inquest::Application.config.notifiable_classes = [Question, Answer, Comment, Vote]
