class StudentsController < ApplicationController
def show
	@student=Student.find(params[:id])
	@course=@student.course.name
	
	# @id=@student.course_id
	# if @id.present?
	# 	@course=Course.where(id:@id).first.course
	# end



	# debugger

end

	
def create
	courses=Course.find(params[:course][:id])
	# debugger
	courses.students.create(create_student_params)
	redirect_to(root_path)	
end

def edit
	@courses=Course.all
	@student = Student.find(params[:id])

	
end	

def update
	 @student = Student.find(params[:id])
	if @student.update_attributes(update_student_params)
		redirect_to student_path(@student)
	end 
end

def destroy
	Student.destroy(params[:id])
	redirect_to(root_path)
end


def index
	@students=Student.order(created_at: :desc).all

	# debugger
	# @courses=Course.all
	respond_to do |format|
	    format.html
    	format.xlsx
    response.headers['Content-Disposition'] = 'attachment; filename="all_students.xlsx"'
    # format.xlsx {render xlsx: 'index',filename: "students.xlsx"}
	end
end

def student_pdf
	@student = Student.find(params[:student])
	html=render_to_string(:action=>'each_student_pdf.html.erb',:layout=>false)
    pdf=PDFKit.new(html)

 
    send_data(pdf.to_pdf) 
	# debugger
end

def download_pdf
    # @students=Student.all
    @students=Student.order(created_at: :desc).all
    @student=Student.find(25)


    #Using Delayed_jobs
    # html=render_to_string(:action=>'download_PDF.html.erb',:layout=>false)
    # pdf=PDFKit.new(html)

 	# 5.times do
  #   	StudentMailer.delay.student_email(@student,pdf.to_pdf)
  #  	end
  #   # send_data(pdf.to_pdf) 
    
  #   redirect_to student_path(@student),notice:"successfully delivered"


  	#Using Sidekiq
    SidekiqWorker.perform_async(@student.id)
    redirect_to student_path(@student),notice:"successfully delivered"

    # debugger

end

private

	def create_student_params
		params.require(:student).permit(:Name,:DOB,:Phone_No,:email)
	end	

private

	def update_student_params
		params.require(:updateStudent).permit(:Name,:DOB,:Phone_No,:email,:course_id)
	end	
	


end
