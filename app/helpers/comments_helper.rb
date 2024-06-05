module CommentsHelper
  def commentable_path(commentable)
    case commentable
    when Idea
      idea_path(commentable)
    when Lesson
      course_lesson_path(commentable.course, commentable)
    end
  end
end