module CommentsHelper
  def comment_url(commentable)
    path = if commentable.is_a?(Answer)
      question_answer_comments_path(commentable.question, commentable)
    else
      question_comments_path(commentable)
    end
  end
end