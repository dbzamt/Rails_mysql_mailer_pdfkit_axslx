class StudentMailerPreview < ActionMailer::Preview
	def student_email_preview
		StudentMailer.student_email(Student.last);
	end
end