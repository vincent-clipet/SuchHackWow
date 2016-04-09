

function xor(x,y)
{
	return x^y;
}

/** (2 ** maxIter) - 1 */
function getMaxBinaryValueByBitNumber(maxIter)
{
	var ret = 0;

	for(var iter=0; iter<maxIter; iter++)
		ret += Math.pow(2, iter);

	return ret;
}

function unknownFunction1(x,y)
{
	y = y % 8;
	Ï = getMaxBinaryValueByBitNumber(y);
	Ï = (x & Ï) << (8-y);

	return (Ï) + (x >> y);
}

function unknownFunction2(passwordInput)
{
	var ret = "";

	// length = 98
	var ð= "\x71\x11\x24\x59\x8d\x6d\x71\x11\x35\x16\x8c\x6d\x71\x0d\x39\x47\x1f\x36\xf1\x2f\x39\x36\x8e\x3c\x4b\x39\x35\x12\x87\x7c\xa3\x10\x74\x58\x16\xc7\x71\x56\x68\x51\x2c\x8c\x73\x45\x32\x5b\x8c\x2a\xf1\x2f\x3f\x57\x6e\x04\x3d\x16\x75\x67\x16\x4f\x6d\x1c\x6e\x40\x01\x36\x93\x59\x33\x56\x04\x3e\x7b\x3a\x70\x50\x16\x04\x3d\x18\x73\x37\xac\x24\xe1\x56\x62\x5b\x8c\x2a\xf1\x45\x7f\x86\x07\x3e\x63\x47";

	for(var i=0;i<ð.length;i++)
	{
		c = ð.charCodeAt(i);

		if (i != 0)
		{
			t = ret.charCodeAt(i-1)%2;

			switch(t)
			{
				case 0:
				cr = xor(c, passwordInput.charCodeAt(i % passwordInput.length));
				break;
				case 1:
				cr = unknownFunction1(c, passwordInput.charCodeAt(i % passwordInput.length));
				break;
			}
		}
		else
		{
			cr = xor(c, passwordInput.charCodeAt(i % passwordInput.length));
		}
		ret += String.fromCharCode(cr);
	}

	return ret;
}

function infiniteLoop(param1)
{
	var counter=0;

	for(var i=0;i<param1.length;i++)
	{
		counter+=param1["charCodeAt"](i)
	}

	if(counter==8932)
	{
		var popup=window.open("", "", "width=300,height=2 0");
		popup.document.write(param1)
	}
	else
	{
		alert("Mauvais mot de passe!")}
	}

	infiniteLoop(unknownFunction2(prompt("Mot de passe ?")));
}
