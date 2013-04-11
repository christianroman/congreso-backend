module Admin
    class MembersController < BaseController
	# GET /members
	# GET /members.json
	def index
	    #@members = Member.limit(100)
	    @members = Member.order('id ASC').page(params[:page]).per(20)

	    respond_to do |format|
		format.html # index.html.erb
	    end
	end

	# GET /members/1
	# GET /members/1.json
	def show
	    @member = Member.find(params[:id])

	    respond_to do |format|
		format.html # show.html.erb
	    end
	end

	# GET /members/new
	# GET /members/new.json
	def new
	    @member = Member.new

	    respond_to do |format|
		format.html # new.html.erb
	    end
	end

	# GET /members/1/edit
	def edit
	    @member = Member.find(params[:id])
	end

	# POST /members
	# POST /members.json
	def create
	    @member = Member.new(params[:member])

	    respond_to do |format|
		if @member.save
		    format.html { redirect_to [:admin, @member], notice: 'Member was successfully created.' }
		else
		    format.html { render action: "new" }
		end
	    end
	end

	# PUT /members/1
	# PUT /members/1.json
	def update
	    @member = Member.find(params[:id])

	    respond_to do |format|
		if @member.update_attributes(params[:member])
		    format.html { redirect_to [:admin, @member], notice: 'Member was successfully updated.' }
		else
		    format.html { render action: "edit" }
		end
	    end
	end

	# DELETE /members/1
	# DELETE /members/1.json
	def destroy
	    @member = Member.find(params[:id])
	    @member.destroy

	    respond_to do |format|
		format.html { redirect_to admin_members_url }
	    end
	end

    end
end
