module AnswersHelper

  def accept_answer_link(answer)
    if answer.question.owned_by?(current_user) && answer.acceptable?
      link_to accept_question_answer_path(answer.question, answer), :id => 'accept_answer', :title => 'Mark this question as accepted.', :method => :put do
        glyph('ok-sign', 3)
      end
    else
      answer.accepted? ? glyph('ok-sign', 3) : ''
    end
  end
end
