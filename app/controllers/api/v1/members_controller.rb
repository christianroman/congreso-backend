require 'open-uri'

module Api
    module V1
    	class MembersController < ApplicationController
	    	skip_before_filter :authorize

	    	def index

	    		if params[:party]
	    			@members = Member.where("party = ?", params[:party])
	    		else
	    			@members = Member.all
	    		end
				@status = @members.blank? ? "NO_RESULTS" : "OK"
				self.response.headers["Content-Type"] = "application/json; charset=UTF-8"
	    	end

		    def nearby
				@members = Member.nearby(params[:latitude], params[:longitude])
				@status = @members.blank? ? "NO_RESULTS" : "OK"
				self.response.headers["Content-Type"] = "application/json; charset=UTF-8"
		    end

		    def diputados
				@members = Member.where("kind = ?", 1)
				@status = @members.blank? ? "NO_RESULTS" : "OK"
				self.response.headers["Content-Type"] = "application/json; charset=UTF-8"
		    end

		    def senadores
				@members = Member.where("kind = ?", 2)
				@status = @members.blank? ? "NO_RESULTS" : "OK"
				self.response.headers["Content-Type"] = "application/json; charset=UTF-8"
		    end

		    def initiatives
		    	@initiatives = Array.new
			    for t in 1..6 do
					doc = Nokogiri::HTML(open("http://sitl.diputados.gob.mx/LXII_leg/iniciativas_por_pernplxii.php?iddipt=#{params[:id]}&pert=#{t}"))
					tds = doc.css("table")[1].css("td")
					i = 0
					begin
					    if tds[i].text.strip != 'INICIATIVA'
							@initiative = Initiative.new
							@initiative.name = tds[i].text.strip.squeeze(' ')
							@initiative.turn = tds[i+1].text.strip.squeeze(' ')
							@initiative.overview = tds[i+2].text.strip.squeeze(' ')
							@initiative.status = tds[i+3].text.strip.squeeze(' ')
							@initiatives << @initiative
					    end
					    i += 4
					end while i < tds.length
			    end
				@status = @initiatives.blank? ? "NO_RESULTS" : "OK"
				self.response.headers["Content-Type"] = "application/json; charset=UTF-8"
		    end

		    def votes
		    	fecha = nil
			    @votes = Array.new
			    for t in 1..6 do
					doc = Nokogiri::HTML(open("http://sitl.diputados.gob.mx/LXII_leg/votaciones_por_pernplxii.php?iddipt=#{params[:id]}&pert=#{t}"))
					trs = doc.css("table table")[1].css("tr")
					trs.each do |tr|
					    if tr.at_css("td.TitulosVerde")
							fecha = tr.at_css("td.TitulosVerde").text
					    end
					    if tr.css("td").length > 1
							@vote = Vote.new
							@vote.date = fecha
							@vote.title = tr.css("td")[1].text.strip.squeeze(' ')
							@vote.vote = tr.css("td")[3].text.strip.squeeze(' ')
							@votes << @vote
					    end
					end
			    end
			    @status = @votes.blank? ? "NO_RESULTS" : "OK"
				self.response.headers["Content-Type"] = "application/json; charset=UTF-8"
		    end

		    def attendances
		    	fecha = nil
			    @attendances = Array.new
			    for t in 1..6 do
					doc = Nokogiri::HTML(open("http://sitl.diputados.gob.mx/LXII_leg/asistencias_por_pernplxii.php?iddipt=#{params[:id]}&pert=#{t}"))
					trs = doc.css("table table")[1].css("tr table")[2]
					trs.css("table table").each do |mes|
						mes.css("td").each do |td|
							if td.at_css("span.TitulosVerde")
							    fecha = td.at_css("span.TitulosVerde").text
							end
							if td.attr("bgcolor") == '#D6E2E2'
							    @attendance = Attendance.new
							    @attendance.date = fecha.strip.squeeze(' ')
							    @attendance.day = td.at_css("font").inner_html.split("<br>")[0].strip
							    @attendance.status = td.at_css("font").inner_html.split("<br>")[1].strip
							    @attendances << @attendance
							end
					    end
					end
			    end
			    @status = @attendances.blank? ? "NO_RESULTS" : "OK"
				self.response.headers["Content-Type"] = "application/json; charset=UTF-8"
		    end

		end
    end
end
