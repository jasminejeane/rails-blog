class ArticlesController < ApplicationController
	http_basic_authenticate_with name: "dhh", password: "secret",
except: [:index, :show]

	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
	end


	# this is a plain action rails. nothing defined within
	# it. Rails expects a view to be associated with it
	def new
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create	
		@article = Article.new(article_params)

		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def update
		@article = Article.find(params[:id])

		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		redirect_to articles_path
	end

	private
		def article_params
			params.require(:article).permit(:title, :text)
		end
end
