import Foundation

class ConverterDataToModel {
    
    func convertMovieDataToModel(movieData: SearchMovieData?) -> SearchMovieModel? {
        
        guard let movieData else { return nil }
        guard let results = movieData.results else { return nil }
        
        var newResults: [MovieResultModel] = []
        guard let page = movieData.page else { return nil }
                
        for item in results {
            
            guard
                let title = item.title,
                let id = item.id,
                let logo = item.logo,
                let mainImage = item.mainImage,
                let overview = item.overview,
                let genresList = item.genresList,
                let popularity = item.popularity,
                let releaseDate = item.releaseDate,
                let voteAverage = item.voteAverage,
                let voteCount = item.voteCount else {
                
                return nil
            }
            let movieModel: MovieResultModel = MovieResultModel(
                title: title,
                mainImage: mainImage,
                genresList: genresList,
                id: id,
                overview: overview,
                popularity: popularity,
                logo: logo,
                releaseDate: releaseDate,
                voteAverage: voteAverage,
                voteCount: voteCount
            )
            
            newResults.append(movieModel)
        }
        return .init(page: page, results: newResults)
    }
    
    func convertVideoDataToModel(videoData: VideosData?) -> VideosModel? {
        
        guard let videoData else { return nil }
        guard let videoResults = videoData.results else { return nil }
        
        var newVideoResults: [VideoResultModel] = []
        for item in videoResults {
            
            guard
                let id = item.id,
                let type = item.type,
                let key = item.key,
                let name = item.name,
                let site = item.site else {
                return nil
            }
            let videoResultModel = VideoResultModel(
                name: name,
                key: key,
                site: site,
                type: type,
                id: id
            )
            newVideoResults.append(videoResultModel)
        }
        return.init(results: newVideoResults)
    }
    
    func convertGenresListDataToModel(genresListData: ListOfGenresData?) -> ListOfGenresModel? {
        
        guard let genresListData else { return nil }
        guard let results = genresListData.genres else { return nil }
        
        var newResults: [GenresModel] = []
        for item in results {
            
            guard
                let name = item.name,
                let id = item.id else {
                return nil
            }
            let genresModel = GenresModel(
                id: id,
                name: name
            )
            newResults.append(genresModel)
        }
        return .init(genres: newResults)
    }
}

