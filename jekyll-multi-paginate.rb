
module Jekyll
  module Multi
    module Paginate
    class MultiPaginate < Page
      def initialize(site, base, dir, pagepath, useindex, pagination)
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
        self.data['pagination']=pagination
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
      def getpost (posts,page,rulekey,orand)
        isor =orand=="or"
        isand =orand=="and"
        oncatpost=[]
        posts.each do |post|
          if rulekey.is_a?(String)
            if (post.data[rulekey]==page.data[rulekey] || rulekey=="all") && rulekey!=""
              oncatpost << post
            end
          # elsif rulekey.is_a?(Array)
          #   isalltrue = true
          #   for i in 0..rulekey.length-1
          #     oky = rulekey[i]
          #     if post.data[oky]==page.data[oky] && oky!=""
          #       isalltrue=true
          #       break if isor
          #     else
          #       isalltrue=false
          #       break if isand
          #     end
          #   end
          #   if isalltrue
          #     oncatpost << post
          #   end
          elsif rulekey.is_a?(Hash)
            isalltrue = true
            rulekey.each do |key, val|
              if post.data[key]==val
                isalltrue = true
                break if isor
              else
                isalltrue = false
                break if isand
              end
            end
            if isalltrue
              oncatpost << post
            end
          end
        end
        return oncatpost
      end
      def getpostbyfm(ff,page,atleastkey,orand)
        isor =orand=="or"
        isand =orand=="and"
        oncatpost=ff
        if atleastkey.is_a?(Array)
          for i in 0..atleastkey.length-1
            if isand
              oncatpost&=getpost(oncatpost,page,atleastkey[i],orand)
            end
            if isor
              oncatpost+=getpost(oncatpost,page,atleastkey[i],orand)
            end
          end
          oncatpost = oncatpost.uniq
        else
          oncatpost=getpost(oncatpost,page,atleastkey,orand)
        end
        return oncatpost
      end
      def generate(site)
        puts("Running Jekyll Multi Paginate")
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
            atleastkey = page.data['paginate_atleastkey'] || "all"
            dir = site.config['page_path'] || nametofolderpath+"/page:num"
            if !dir.include?':num'
              dir+=":num"
            end
            oncatpost = site.posts.docs
            postlen = 0
            oncatpost = getpostbyfm(oncatpost,page,onlykey,'and')
            oncatpost = getpostbyfm(oncatpost,page,atleastkey,'or')
            postlen = oncatpost.length
            toloop = postlen.to_f/postmax.to_f
            for i in 1..toloop.ceil
              posts = oncatpost[(i-1)*postmax,postmax]

              ndir = toPagePath(dir, i)
              pagepaths = []
              [*1..toloop.ceil].each do |x|
                pagepaths.push(toPagePath(dir, x))
              end
              pagination = {
                "nums" => [*1..toloop.ceil],
                "posts" => posts,
                "paths" => pagepaths,
                "paginate_num" => toloop.ceil,
                "paginate_path" => "/"+dir+"/".gsub("//","/"),
                "total_post" => postlen,
                "current_num" => i,
                "prev_path" => ((i-1)!=0)? toPagePath(dir, i-1):nil,
                "next_path" => ((i+1)<=toloop.ceil)? toPagePath(dir, i+1):nil,
                "prev_num" => ((i-1)!=0)? i-1:nil,
                "next_num" => ((i+1)<=toloop.ceil)? i+1:nil,
              }
              if i==1
                site.pages << MultiPaginate.new(site, site.source, pagepath, page.path, false, pagination)
                if !(site.permalink_style.downcase=="pretty")
                  site.pages << MultiPaginate.new(site, site.source, nametofolderpath, page.path, true, pagination)
                end
              end
              site.pages << MultiPaginate.new(site, site.source, ndir, page.path, true, pagination)
            end
          end
        end
      end
    end
    end
  end
end
