module VotesHelper

  def vote_button(voteable, direction)
    icon = glyph("arrow-#{direction}", 3)
    path = if voteable.is_a?(Answer)
      question_answer_votes_path(voteable.question, voteable, :direction => direction)
    else
      question_votes_path(voteable, :direction => direction)
    end

    if current_user.voted_on?(voteable, direction) 
      icon
    elsif !current_user.voted_on?(voteable)
      link_to path, :method => :post, :class => 'vote_button' do
        icon
      end
    else
      content_tag :span, :class => 'vote_button disabled' do
        icon
      end
    end
  end

  def vote_score(voteable) 
    content_tag(:h4, voteable.vote_score, :class => 'vote-score')
  end
end
