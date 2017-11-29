
class StudentMailer < ActionMailer::Base
	default from: "amitmh25@gmail.com"

	def student_email(student,pdf)
	    @student = student
	    @pdf=pdf

	    # attachments['download_show.pdf'] = File.read('/home/amit/Downloads/download_show.pdf')
		attachments['download_show.pdf'] = @pdf
		# sleep 30
		mail(to: 'amitmh25@gmail.com', subject: 'Sample Email').deliver
		# debugger
# c
    end

    

end
