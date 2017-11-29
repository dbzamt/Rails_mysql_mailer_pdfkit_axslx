class SidekiqWorker
	include Sidekiq::Worker

	def perform(student_id)
		student=Student.find(student_id)
		ac = ActionController::Base.new()
		html=ac.render_to_string(:template=>'/students/sidekiq_pdf.html.erb',:layout=>false,:locals => {:student => student})
	    pdf=PDFKit.new(html)

	 	5.times do
	    	StudentMailer.student_email(student,pdf.to_pdf).deliver
	   	end
	    # send_data(pdf.to_pdf) SIDEKIQ
	    
	end
	
end
