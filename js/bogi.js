var line = 5;

Array.prototype.forEach.call(document.querySelectorAll('#app li'), function(v, i) {
	v.innerText = i + 1;
  if (i < line) v.classList.add('on');
});

document.querySelector('#app button').addEventListener('click', function(e) {
	var visible = document.querySelectorAll('#app li.on').length;
  var all = document.querySelectorAll('#app li').length;
  
  if (visible === all) visible = line;
  else visible = Math.min(all, visible + line);
  
  this.querySelector('.front').innerText = visible;
  this.querySelector('.end').innerText = all;
  
  Array.prototype.forEach.call(document.querySelectorAll('#app li'), function(v, i) {
  	if (i < visible) v.classList.add('on');
    else v.classList.remove('on');
  });
});

document.querySelector('#app button .front').innerText = line;
document.querySelector('#app button .end').innerText = document.querySelectorAll('#app li').length;