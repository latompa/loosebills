
$(function() {
 
 offset=0;
 $('ul.cash li.bill').each(function(gg) {
   denomination = $(this).attr('class').replace("bill", "").replace(" ","")
   $(this).html("<img src='/images/" + denomination + ".jpg'/>");
   
   $(this).css('top', offset +"px");
   $(this).css('left', offset + "px");
   offset += 20;   
 });
 
 $('#hint_link').click(function() {
   $('#user_hints').toggle();
 });
 
});