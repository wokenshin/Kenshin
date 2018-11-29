function showSheet(title,cancelButtonTitle,destructiveButtonTitle,otherButtonTitle)
{
    var url = 'kenshin://?';
    var paramas = title + '&' + cancelButtonTitle + '&' + destructiveButtonTitle;
    if(otherButtonTitle)
    {
        paramas += '&' + otherButtonTitle;
        
    }
    window.location.href = url + encodeURIComponent(paramas);

}

var blog = document.getElementById('blog');
blog.onclick = function()
{
    showSheet('系统提示', '取消', '确定', null);

};

//其实这种js的页面交互的效果 感觉还是没有原声的及时 而且双击的时候页面会下移［下移应该可以修复］