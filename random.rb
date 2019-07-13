require 'sketchup.rb'


#正题
#class Colors
#module Rand_tile
def dia
	model = Sketchup.active_model
	sel=model.selection
	
	results = []
	color = []
	alpha=[]
	count=0
	while results !=["","",""]
		prompts = ["R:","G:","B:"]
		values=[]
		results=inputbox(prompts,values,"连续选择被选颜色")#未来预览颜色
		color.push results
	end
	color.pop#删除最后无效数值
	#model.start_operation("随机颜色", true)
	sel.each do
		click=sel[count]
			if click.typename==("Face")
			random_col=rand(color.length).to_i#转换成数组
			puts color[random_col].to_a#存储
			fincol=color[random_col]
			
			
			click.material=[fincol[0].to_i,fincol[1].to_i,fincol[2].to_i]
		end
		count=count+1
	end
	
end#dia
#end#class color

#暂缺随机按钮以及预览考虑改用script？

#路径
def find_Logo(file_name="")
	path=Sketchup.find_support_file file_name,"plugins/logo"
	return path
end
#添加菜单
def tool_bar
pmenu=UI.menu("Plugins")
submenu=pmenu.add_submenu("randomtile")
submenu.add_item("randomtile"){dia}
toolbar = UI::Toolbar.new "随机铺装"

cmd=UI::Command.new("randomtile"){dia}
cmd.small_icon=find_Logo "logo.png"
cmd.large_icon=find_Logo "logo.png"
cmd.tooltip="选择面进行随机面着色"
toolbar = toolbar.add_item cmd
toolbar.show
end#tool_bar
#--------------------
unless file_loaded?(__FILE__)
	tool_bar
	file_loaded(__FILE__)
end#unless
#end#module