module Admin
    class StatesController < BaseController
	# GET /states
	# GET /states.json
	def index
	    @states = State.all

	    respond_to do |format|
		format.html # index.html.erb
	    end
	end

	# GET /states/1
	# GET /states/1.json
	def show
	    @state = State.find(params[:id])

	    respond_to do |format|
		format.html # show.html.erb
	    end
	end

	# GET /states/new
	# GET /states/new.json
	def new
	    @state = State.new

	    respond_to do |format|
		format.html # new.html.erb
	    end
	end

	# GET /states/1/edit
	def edit
	    @state = State.find(params[:id])
	end

	# POST /states
	# POST /states.json
	def create
	    @state = State.new(params[:state])

	    respond_to do |format|
		if @state.save
		    format.html { redirect_to [:admin, @state], notice: 'State was successfully created.' }
		else
		    format.html { render action: "new" }
		end
	    end
	end

	# PUT /states/1
	# PUT /states/1.json
	def update
	    @state = State.find(params[:id])

	    respond_to do |format|
		if @state.update_attributes(params[:state])
		    format.html { redirect_to [:admin, @state], notice: 'State was successfully updated.' }
		else
		    format.html { render action: "edit" }
		end
	    end
	end

	# DELETE /states/1
	# DELETE /states/1.json
	def destroy
	    @state = State.find(params[:id])
	    @state.destroy

	    respond_to do |format|
		format.html { redirect_to admin_states_url }
	    end
	end
    end
end
