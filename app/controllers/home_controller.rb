class HomeController < ApplicationController
   def index
  	@students=Student.order(created_at: :desc).all
  	@courses=Course.all

  	respond_to do |format|
	    format.html
	    format.xls
	    # format.xlsx {render xlsx: 'index',filename: "students.xlsx"}
  	end
  end

  def download_pdf
    # @students=Student.all
    @students=Student.order(created_at: :desc).all
    @student=Student.find(25)

    html=render_to_string(:action=>'download_PDF.html.erb',:layout=>false)
    pdf=PDFKit.new(html)
    # send_data(pdf.to_pdf)
    StudentMailer.student_email(@student,pdf.to_pdf).deliver
    debugger

  end

  def delivered
    @student=Student.find(params[:id])
    
  end
   def ques
  	redirect_to root_path
   end
end
	