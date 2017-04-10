var isLoaded = false;
var moveDown = false;
var upperLimit = -50;
var lowerLimit = -40;
var movingStep = 1;
var bar_movingStep = 5;
var frameDelay = 20;

var bar_targetWidth;
var greenBar;
var redBar;

function loadSvg(params) {
	var client = new XMLHttpRequest();
	client.open('GET', 'resultBar.svg');
	client.onreadystatechange = function() {
		if (client.responseText && !isLoaded)
		{
			isLoaded = true;
			console.log("Loaded svg file");
			var target = document.getElementById("svgBox");
			target.innerHTML = client.responseText;
			setParams(params);
		}
	}
	client.send();
}

function setParams(params){
	greenBar = document.getElementById("greenBar");
	redBar = document.getElementById("redBar");
	var textBox = document.getElementById("mainText");
	var imageBox = document.getElementById("icon");
	bar_targetWidth = params.percentageCorrect * redBar.getAttribute("width");
	greenBar.setAttribute("width", 0);
	textBox.innerHTML = params.text;
	imageBox.setAttribute("xlink:href", params.icon);
	setTimeout(function(){ moveIcon(imageBox); }, frameDelay);
	setTimeout(function(){ barFlow(greenBar); }, frameDelay);
}

function barFlow(bar)
{
	var currentWidth = parseInt(bar.getAttribute("width"));
	console.log("Width is " + currentWidth);
	currentWidth += bar_movingStep;
	if(currentWidth > bar_targetWidth)
	{
		currentWidth = bar_targetWidth;
	}
	else
		setTimeout(function(){ barFlow(bar); }, frameDelay);
	bar.setAttribute("width", currentWidth);
}

function moveIcon(icon)
{
	var y = parseInt(icon.getAttribute("y"));
	if(moveDown)
	{
		y += movingStep;
		if(y > lowerLimit)
		{
			y = lowerLimit;
			moveDown = false;
		}
		
	}
	else
	{
		y -= movingStep;
		if(y < upperLimit)
		{
			y = upperLimit;
			moveDown = true;
		}
	}
	icon.setAttribute("y", y);
	setTimeout(function(){ moveIcon(icon); }, frameDelay);
}