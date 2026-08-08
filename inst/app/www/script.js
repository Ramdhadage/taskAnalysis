
      $(function(){
        $('.card')
        .find('[data-card-widget=\"maximize\"]')
        .on('click', function(e) {
          // it may take some time for the resizing of the card to happen
          setTimeout(function(){
            let chart = $(e.target)
              .closest('.card')
              .find('.echarts4r')
              .first();

            if(!chart)
              return;

            let id = chart.attr('id')

            let $parent = $(chart).parent();
            let w = $parent.width();
            let h = $parent.height();
            console.log(h);
            $('#chart').parent().css({
              width: w + 'px',
              height: h + 'px'
            })
            get_e_charts(id).resize({width: w, height: h});
          }, 250);
        });
      });
