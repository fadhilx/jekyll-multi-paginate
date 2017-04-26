
module Jekyll
  module Multi
    module Paginate
    class MultiPaginate < Page
      def initialize(site, base, dir, pagepath, useindex, instance)
        @site = site
        @base = base
        @dir = dir
        if (File.extname(pagepath)==".html" && site.permalink_style=="pretty")||(useindex && File.extname(pagepath)==".html")
          @name = 'index.html'
        else
          @name = File.basename(pagepath)
        end
        self.process(@name)
        self.read_yaml(base, pagepath)
        self.data['instance']=instance
        self.data.delete "paginate"
      end
    end

    class MultiPaginateGenerator < Generator
      safe true
      def toPagePath(dir, num)
        dirn =("/"+dir.gsub(':num', num.to_s)+"/")
        while dirn.include?'//'
          dirn=dirn.gsub("//","/")
        end
        return dirn
      end
      def generate(site)
        site.pages.each do |page|
          if page.data.has_key?"paginate"
            file = page.url
            nametofolderpath = file.sub(File.extname(file),"")
            if site.permalink_style=="pretty"
              pagepath = file.sub(File.extname(file),"")
            else
              pagepath = File.dirname(file)
            end
            postmax = page.data['paginate']
            onlykey = page.data['paginate_onlykey'] || "all"
            dir = site.config['page_path'] || nametofolderpath+"/page:num"
            if !dir.include?':num'
              dir+=":num"
            end
            oncatpost = []
            postlen = 0
            site.posts.docs.each do |post|
              if (post.data[onlykey]==page.data[onlykey] || onlykey=="all") && onlykey!=""
                oncatpost << post
                postlen+=1
              end
            end
            toloop = postlen.to_f/postmax.to_f
            for i in 1..toloop.ceil
              posts = oncatpost[(i-1)*postmax,postmax]

              ndir = toPagePath(dir, i)
              pagepaths = []
              [*1..toloop.ceil].each do |x|
                pagepaths.push(toPagePath(dir, x))
              end
              instance = {
                "nums" => [*1..toloop.ceil],
                "posts" => posts,
                "paths" => pagepaths,
                "paginate_num" => toloop.ceil,
                "paginate_path" => "/"+dir+"/".gsub("//","/"),
                "total_post" => postlen,
                "current_num" => i,
                "total_page_num" => toloop.ceil,
                "prev_path" => ((i-1)!=0)? toPagePath(dir, i-1):nil,
                "next_path" => ((i+1)<=toloop.ceil)? toPagePath(dir, i+1):nil,
                "prev_num" => ((i-1)!=0)? i-1:nil,
                "next_num" => ((i+1)<=toloop.ceil)? i+1:nil,
              }
              if i==1
                site.pages << MultiPaginate.new(site, site.source, pagepath, page.path, false, instance)
                if !(site.permalink_style.downcase=="pretty")
                  site.pages << MultiPaginate.new(site, site.source, nametofolderpath, page.path, true, instance)
                end
              end
              site.pages << MultiPaginate.new(site, site.source, ndir, page.path, true, instance)
            end
          end
        end
      end
    end
    end
  end
end
