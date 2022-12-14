class ProdutosController < ApplicationController
    def index
        @produtos_nome = Produto.order(:nome).limit 5
        @produtos_preco = Produto.order(:preco).limit 3
    end

    def new
        @produto = Produto.new
        @departamentos = Departamento.all
    end

    def create
        valores = params.require(:produto).permit :nome, :descricao, :preco, :quantidade, :departamento_id
        @produto = Produto.create valores
        if @produto.save
            flash[:notice] = "Produto salvo com sucesso"
            redirect_to root_url
        else
            render :new
        end
    end

    def busca
        @nome_a_buscar = params[:nome]
        @produtos = Produto.where "nome like ?", "%#{@nome_a_buscar}%"
    end

    def destroy
        id = params[:id]
        Produto.destroy id
        redirect_to root_url
    end
end
