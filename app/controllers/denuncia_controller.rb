class DenunciaController < ApplicationController

  # POST /denuncia
  # POST /denuncia.json
  def create
    @denuncium = Denuncium.new(denuncium_params)

    if @denuncium.save
      redirect_to root_path, notice: 'Denuncium was successfully created.'
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def denuncium_params
      params.require(:denuncium).permit(:data, :hora, :endereco, :descricao, :x, :y)
    end
end
