class GuntypesController < ApplicationController
  before_action :set_guntype, only: [:show, :edit, :update, :destroy]

  # GET /guntypes
  # GET /guntypes.json
  def index
    @guntypes = Guntype.all
  end

  # GET /guntypes/1
  # GET /guntypes/1.json
  def show
  end

  # GET /guntypes/new
  def new
    @guntype = Guntype.new
  end

  # GET /guntypes/1/edit
  def edit
  end

  # POST /guntypes
  # POST /guntypes.json
  def create
    @guntype = Guntype.new(guntype_params)

    respond_to do |format|
      if @guntype.save
        format.html { redirect_to @guntype, notice: 'Guntype was successfully created.' }
        format.json { render :show, status: :created, location: @guntype }
      else
        format.html { render :new }
        format.json { render json: @guntype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guntypes/1
  # PATCH/PUT /guntypes/1.json
  def update
    respond_to do |format|
      if @guntype.update(guntype_params)
        format.html { redirect_to @guntype, notice: 'Guntype was successfully updated.' }
        format.json { render :show, status: :ok, location: @guntype }
      else
        format.html { render :edit }
        format.json { render json: @guntype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guntypes/1
  # DELETE /guntypes/1.json
  def destroy
    @guntype.destroy
    respond_to do |format|
      format.html { redirect_to guntypes_url, notice: 'Guntype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guntype
      @guntype = Guntype.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def guntype_params
      params.require(:guntype).permit(:gunshottype)
    end
end
