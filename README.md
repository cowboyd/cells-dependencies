
# Cell Dependencies

This is little gemmy what let's you declare ahead of render-time
what other cells a cell depends on. 

Let's say you've got a hot banner that you put in all of your widgets

    class BannerCell < Cell::Rails
        #... your banner is awesome, and does great stuff.
    end

You can now declare in your other cells that they use this banner cell

    class WeatherCell < Cell::Rails
      uses :banner
      #other great stuff...
    end

and then query your cell to find out which cells it depends on

    WeatherCell.dependencies #=> [BannerCell]

Dependencies are transitive

    class BannerCell < Cell::Rails
      uses :logo
    end
    
    WeatherCell.dependencies #=> [BannerCell, LogoCell]

