/*!
 * jQuery Cookie Plugin v1.1
 * https://github.com/carhartl/jquery-cookie
 *
 * Copyright 2011, Klaus Hartl
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.opensource.org/licenses/GPL-2.0
 */
(function($, document) {

	var pluses = /\+/g;
	function raw(s) {
		return s;
	}
	function decoded(s) {
		return decodeURIComponent(s.replace(pluses, ' '));
	}

	$.cookie = function(key, value, options) {

		// key and at least value given, set cookie...
		if (arguments.length > 1 && (!/Object/.test(Object.prototype.toString.call(value)) || value == null)) {
			options = $.extend({}, $.cookie.defaults, options);

			if (value == null) {
				options.expires = -1;
			}

			if (typeof options.expires === 'number') {
				var days = options.expires, t = options.expires = new Date();
				t.setDate(t.getDate() + days);
			}

			value = String(value);

			return (document.cookie = [
				encodeURIComponent(key), '=', options.raw ? value : encodeURIComponent(value),
				options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
				options.path    ? '; path=' + options.path : '',
				options.domain  ? '; domain=' + options.domain : '',
				options.secure  ? '; secure' : ''
			].join(''));
		}

		// key and possibly options given, get cookie...
		options = value || $.cookie.defaults || {};
		var decode = options.raw ? raw : decoded;
		var cookies = document.cookie.split('; ');
		for (var i = 0, parts; (parts = cookies[i] && cookies[i].split('=')); i++) {
			if (decode(parts.shift()) === key) {
				return decode(parts.join('='));
			}
		}
		return null;
	};

	$.cookie.defaults = {};

})(jQuery, document);

var _fonts = '<option value="">Default</option><option value="ABeeZee">ABeeZee</option><option value="Abel">Abel</option><option value="Abril Fatface">Abril Fatface</option><option value="Aclonica">Aclonica</option><option value="Acme">Acme</option><option value="Actor">Actor</option><option value="Adamina">Adamina</option><option value="Advent Pro">Advent Pro</option><option value="Aguafina Script">Aguafina Script</option><option value="Akronim">Akronim</option><option value="Aladin">Aladin</option><option value="Aldrich">Aldrich</option><option value="Alef">Alef</option><option value="Alegreya">Alegreya</option><option value="Alegreya SC">Alegreya SC</option><option value="Alegreya Sans">Alegreya Sans</option><option value="Alegreya Sans SC">Alegreya Sans SC</option><option value="Alex Brush">Alex Brush</option><option value="Alfa Slab One">Alfa Slab One</option><option value="Alice">Alice</option><option value="Alike">Alike</option><option value="Alike Angular">Alike Angular</option><option value="Allan">Allan</option><option value="Allerta">Allerta</option><option value="Allerta Stencil">Allerta Stencil</option><option value="Allura">Allura</option><option value="Almendra">Almendra</option><option value="Almendra Display">Almendra Display</option><option value="Almendra SC">Almendra SC</option><option value="Amarante">Amarante</option><option value="Amaranth">Amaranth</option><option value="Amatic SC">Amatic SC</option><option value="Amethysta">Amethysta</option><option value="Amiri">Amiri</option><option value="Amita">Amita</option><option value="Anaheim">Anaheim</option><option value="Andada">Andada</option><option value="Andika">Andika</option><option value="Angkor">Angkor</option><option value="Annie Use Your Telescope">Annie Use Your Telescope</option><option value="Anonymous Pro">Anonymous Pro</option><option value="Antic">Antic</option><option value="Antic Didone">Antic Didone</option><option value="Antic Slab">Antic Slab</option><option value="Anton">Anton</option><option value="Arapey">Arapey</option><option value="Arbutus">Arbutus</option><option value="Arbutus Slab">Arbutus Slab</option><option value="Architects Daughter">Architects Daughter</option><option value="Archivo Black">Archivo Black</option><option value="Archivo Narrow">Archivo Narrow</option><option value="Arimo">Arimo</option><option value="Arizonia">Arizonia</option><option value="Armata">Armata</option><option value="Artifika">Artifika</option><option value="Arvo">Arvo</option><option value="Arya">Arya</option><option value="Asap">Asap</option><option value="Asar">Asar</option><option value="Asset">Asset</option><option value="Astloch">Astloch</option><option value="Asul">Asul</option><option value="Atomic Age">Atomic Age</option><option value="Aubrey">Aubrey</option><option value="Audiowide">Audiowide</option><option value="Autour One">Autour One</option><option value="Average">Average</option><option value="Average Sans">Average Sans</option><option value="Averia Gruesa Libre">Averia Gruesa Libre</option><option value="Averia Libre">Averia Libre</option><option value="Averia Sans Libre">Averia Sans Libre</option><option value="Averia Serif Libre">Averia Serif Libre</option><option value="Bad Script">Bad Script</option><option value="Balthazar">Balthazar</option><option value="Bangers">Bangers</option><option value="Basic">Basic</option><option value="Battambang">Battambang</option><option value="Baumans">Baumans</option><option value="Bayon">Bayon</option><option value="Belgrano">Belgrano</option><option value="Belleza">Belleza</option><option value="BenchNine">BenchNine</option><option value="Bentham">Bentham</option><option value="Berkshire Swash">Berkshire Swash</option><option value="Bevan">Bevan</option><option value="Bigelow Rules">Bigelow Rules</option><option value="Bigshot One">Bigshot One</option><option value="Bilbo">Bilbo</option><option value="Bilbo Swash Caps">Bilbo Swash Caps</option><option value="Biryani">Biryani</option><option value="Bitter">Bitter</option><option value="Black Ops One">Black Ops One</option><option value="Bokor">Bokor</option><option value="Bonbon">Bonbon</option><option value="Boogaloo">Boogaloo</option><option value="Bowlby One">Bowlby One</option><option value="Bowlby One SC">Bowlby One SC</option><option value="Brawler">Brawler</option><option value="Bree Serif">Bree Serif</option><option value="Bubblegum Sans">Bubblegum Sans</option><option value="Bubbler One">Bubbler One</option><option value="Buda">Buda</option><option value="Buenard">Buenard</option><option value="Butcherman">Butcherman</option><option value="Butterfly Kids">Butterfly Kids</option><option value="Cabin">Cabin</option><option value="Cabin Condensed">Cabin Condensed</option><option value="Cabin Sketch">Cabin Sketch</option><option value="Caesar Dressing">Caesar Dressing</option><option value="Cagliostro">Cagliostro</option><option value="Calligraffitti">Calligraffitti</option><option value="Cambay">Cambay</option><option value="Cambo">Cambo</option><option value="Candal">Candal</option><option value="Cantarell">Cantarell</option><option value="Cantata One">Cantata One</option><option value="Cantora One">Cantora One</option><option value="Capriola">Capriola</option><option value="Cardo">Cardo</option><option value="Carme">Carme</option><option value="Carrois Gothic">Carrois Gothic</option><option value="Carrois Gothic SC">Carrois Gothic SC</option><option value="Carter One">Carter One</option><option value="Catamaran">Catamaran</option><option value="Caudex">Caudex</option><option value="Caveat">Caveat</option><option value="Caveat Brush">Caveat Brush</option><option value="Cedarville Cursive">Cedarville Cursive</option><option value="Ceviche One">Ceviche One</option><option value="Changa One">Changa One</option><option value="Chango">Chango</option><option value="Chau Philomene One">Chau Philomene One</option><option value="Chela One">Chela One</option><option value="Chelsea Market">Chelsea Market</option><option value="Chenla">Chenla</option><option value="Cherry Cream Soda">Cherry Cream Soda</option><option value="Cherry Swash">Cherry Swash</option><option value="Chewy">Chewy</option><option value="Chicle">Chicle</option><option value="Chivo">Chivo</option><option value="Chonburi">Chonburi</option><option value="Cinzel">Cinzel</option><option value="Cinzel Decorative">Cinzel Decorative</option><option value="Clicker Script">Clicker Script</option><option value="Coda">Coda</option><option value="Coda Caption">Coda Caption</option><option value="Codystar">Codystar</option><option value="Combo">Combo</option><option value="Comfortaa">Comfortaa</option><option value="Coming Soon">Coming Soon</option><option value="Concert One">Concert One</option><option value="Condiment">Condiment</option><option value="Content">Content</option><option value="Contrail One">Contrail One</option><option value="Convergence">Convergence</option><option value="Cookie">Cookie</option><option value="Copse">Copse</option><option value="Corben">Corben</option><option value="Courgette">Courgette</option><option value="Cousine">Cousine</option><option value="Coustard">Coustard</option><option value="Covered By Your Grace">Covered By Your Grace</option><option value="Crafty Girls">Crafty Girls</option><option value="Creepster">Creepster</option><option value="Crete Round">Crete Round</option><option value="Crimson Text">Crimson Text</option><option value="Croissant One">Croissant One</option><option value="Crushed">Crushed</option><option value="Cuprum">Cuprum</option><option value="Cutive">Cutive</option><option value="Cutive Mono">Cutive Mono</option><option value="Damion">Damion</option><option value="Dancing Script">Dancing Script</option><option value="Dangrek">Dangrek</option><option value="Dawning of a New Day">Dawning of a New Day</option><option value="Days One">Days One</option><option value="Dekko">Dekko</option><option value="Delius">Delius</option><option value="Delius Swash Caps">Delius Swash Caps</option><option value="Delius Unicase">Delius Unicase</option><option value="Della Respira">Della Respira</option><option value="Denk One">Denk One</option><option value="Devonshire">Devonshire</option><option value="Dhurjati">Dhurjati</option><option value="Didact Gothic">Didact Gothic</option><option value="Diplomata">Diplomata</option><option value="Diplomata SC">Diplomata SC</option><option value="Domine">Domine</option><option value="Donegal One">Donegal One</option><option value="Doppio One">Doppio One</option><option value="Dorsa">Dorsa</option><option value="Dosis">Dosis</option><option value="Dr Sugiyama">Dr Sugiyama</option><option value="Droid Sans">Droid Sans</option><option value="Droid Sans Mono">Droid Sans Mono</option><option value="Droid Serif">Droid Serif</option><option value="Duru Sans">Duru Sans</option><option value="Dynalight">Dynalight</option><option value="EB Garamond">EB Garamond</option><option value="Eagle Lake">Eagle Lake</option><option value="Eater">Eater</option><option value="Economica">Economica</option><option value="Eczar">Eczar</option><option value="Ek Mukta">Ek Mukta</option><option value="Electrolize">Electrolize</option><option value="Elsie">Elsie</option><option value="Elsie Swash Caps">Elsie Swash Caps</option><option value="Emblema One">Emblema One</option><option value="Emilys Candy">Emilys Candy</option><option value="Engagement">Engagement</option><option value="Englebert">Englebert</option><option value="Enriqueta">Enriqueta</option><option value="Erica One">Erica One</option><option value="Esteban">Esteban</option><option value="Euphoria Script">Euphoria Script</option><option value="Ewert">Ewert</option><option value="Exo">Exo</option><option value="Exo 2">Exo 2</option><option value="Expletus Sans">Expletus Sans</option><option value="Fanwood Text">Fanwood Text</option><option value="Fascinate">Fascinate</option><option value="Fascinate Inline">Fascinate Inline</option><option value="Faster One">Faster One</option><option value="Fasthand">Fasthand</option><option value="Fauna One">Fauna One</option><option value="Federant">Federant</option><option value="Federo">Federo</option><option value="Felipa">Felipa</option><option value="Fenix">Fenix</option><option value="Finger Paint">Finger Paint</option><option value="Fira Mono">Fira Mono</option><option value="Fira Sans">Fira Sans</option><option value="Fjalla One">Fjalla One</option><option value="Fjord One">Fjord One</option><option value="Flamenco">Flamenco</option><option value="Flavors">Flavors</option><option value="Fondamento">Fondamento</option><option value="Fontdiner Swanky">Fontdiner Swanky</option><option value="Forum">Forum</option><option value="Francois One">Francois One</option><option value="Freckle Face">Freckle Face</option><option value="Fredericka the Great">Fredericka the Great</option><option value="Fredoka One">Fredoka One</option><option value="Freehand">Freehand</option><option value="Fresca">Fresca</option><option value="Frijole">Frijole</option><option value="Fruktur">Fruktur</option><option value="Fugaz One">Fugaz One</option><option value="GFS Didot">GFS Didot</option><option value="GFS Neohellenic">GFS Neohellenic</option><option value="Gabriela">Gabriela</option><option value="Gafata">Gafata</option><option value="Galdeano">Galdeano</option><option value="Galindo">Galindo</option><option value="Gentium Basic">Gentium Basic</option><option value="Gentium Book Basic">Gentium Book Basic</option><option value="Geo">Geo</option><option value="Geostar">Geostar</option><option value="Geostar Fill">Geostar Fill</option><option value="Germania One">Germania One</option><option value="Gidugu">Gidugu</option><option value="Gilda Display">Gilda Display</option><option value="Give You Glory">Give You Glory</option><option value="Glass Antiqua">Glass Antiqua</option><option value="Glegoo">Glegoo</option><option value="Gloria Hallelujah">Gloria Hallelujah</option><option value="Goblin One">Goblin One</option><option value="Gochi Hand">Gochi Hand</option><option value="Gorditas">Gorditas</option><option value="Goudy Bookletter 1911">Goudy Bookletter 1911</option><option value="Graduate">Graduate</option><option value="Grand Hotel">Grand Hotel</option><option value="Gravitas One">Gravitas One</option><option value="Great Vibes">Great Vibes</option><option value="Griffy">Griffy</option><option value="Gruppo">Gruppo</option><option value="Gudea">Gudea</option><option value="Gurajada">Gurajada</option><option value="Habibi">Habibi</option><option value="Halant">Halant</option><option value="Hammersmith One">Hammersmith One</option><option value="Hanalei">Hanalei</option><option value="Hanalei Fill">Hanalei Fill</option><option value="Handlee">Handlee</option><option value="Hanuman">Hanuman</option><option value="Happy Monkey">Happy Monkey</option><option value="Headland One">Headland One</option><option value="Henny Penny">Henny Penny</option><option value="Herr Von Muellerhoff">Herr Von Muellerhoff</option><option value="Hind">Hind</option><option value="Hind Siliguri">Hind Siliguri</option><option value="Hind Vadodara">Hind Vadodara</option><option value="Holtwood One SC">Holtwood One SC</option><option value="Homemade Apple">Homemade Apple</option><option value="Homenaje">Homenaje</option><option value="IM Fell DW Pica">IM Fell DW Pica</option><option value="IM Fell DW Pica SC">IM Fell DW Pica SC</option><option value="IM Fell Double Pica">IM Fell Double Pica</option><option value="IM Fell Double Pica SC">IM Fell Double Pica SC</option><option value="IM Fell English">IM Fell English</option><option value="IM Fell English SC">IM Fell English SC</option><option value="IM Fell French Canon">IM Fell French Canon</option><option value="IM Fell French Canon SC">IM Fell French Canon SC</option><option value="IM Fell Great Primer">IM Fell Great Primer</option><option value="IM Fell Great Primer SC">IM Fell Great Primer SC</option><option value="Iceberg">Iceberg</option><option value="Iceland">Iceland</option><option value="Imprima">Imprima</option><option value="Inconsolata">Inconsolata</option><option value="Inder">Inder</option><option value="Indie Flower">Indie Flower</option><option value="Inika">Inika</option><option value="Inknut Antiqua">Inknut Antiqua</option><option value="Irish Grover">Irish Grover</option><option value="Istok Web">Istok Web</option><option value="Italiana">Italiana</option><option value="Italianno">Italianno</option><option value="Itim">Itim</option><option value="Jacques Francois">Jacques Francois</option><option value="Jacques Francois Shadow">Jacques Francois Shadow</option><option value="Jaldi">Jaldi</option><option value="Jim Nightshade">Jim Nightshade</option><option value="Jockey One">Jockey One</option><option value="Jolly Lodger">Jolly Lodger</option><option value="Josefin Sans">Josefin Sans</option><option value="Josefin Slab">Josefin Slab</option><option value="Joti One">Joti One</option><option value="Judson">Judson</option><option value="Julee">Julee</option><option value="Julius Sans One">Julius Sans One</option><option value="Junge">Junge</option><option value="Jura">Jura</option><option value="Just Another Hand">Just Another Hand</option><option value="Just Me Again Down Here">Just Me Again Down Here</option><option value="Kadwa">Kadwa</option><option value="Kalam">Kalam</option><option value="Kameron">Kameron</option><option value="Kanit">Kanit</option><option value="Kantumruy">Kantumruy</option><option value="Karla">Karla</option><option value="Karma">Karma</option><option value="Kaushan Script">Kaushan Script</option><option value="Kavoon">Kavoon</option><option value="Kdam Thmor">Kdam Thmor</option><option value="Keania One">Keania One</option><option value="Kelly Slab">Kelly Slab</option><option value="Kenia">Kenia</option><option value="Khand">Khand</option><option value="Khmer">Khmer</option><option value="Khula">Khula</option><option value="Kite One">Kite One</option><option value="Knewave">Knewave</option><option value="Kotta One">Kotta One</option><option value="Koulen">Koulen</option><option value="Kranky">Kranky</option><option value="Kreon">Kreon</option><option value="Kristi">Kristi</option><option value="Krona One">Krona One</option><option value="Kurale">Kurale</option><option value="La Belle Aurore">La Belle Aurore</option><option value="Laila">Laila</option><option value="Lakki Reddy">Lakki Reddy</option><option value="Lancelot">Lancelot</option><option value="Lateef">Lateef</option><option value="Lato">Lato</option><option value="League Script">League Script</option><option value="Leckerli One">Leckerli One</option><option value="Ledger">Ledger</option><option value="Lekton">Lekton</option><option value="Lemon">Lemon</option><option value="Libre Baskerville">Libre Baskerville</option><option value="Life Savers">Life Savers</option><option value="Lilita One">Lilita One</option><option value="Lily Script One">Lily Script One</option><option value="Limelight">Limelight</option><option value="Linden Hill">Linden Hill</option><option value="Lobster">Lobster</option><option value="Lobster Two">Lobster Two</option><option value="Londrina Outline">Londrina Outline</option><option value="Londrina Shadow">Londrina Shadow</option><option value="Londrina Sketch">Londrina Sketch</option><option value="Londrina Solid">Londrina Solid</option><option value="Lora">Lora</option><option value="Love Ya Like A Sister">Love Ya Like A Sister</option><option value="Loved by the King">Loved by the King</option><option value="Lovers Quarrel">Lovers Quarrel</option><option value="Luckiest Guy">Luckiest Guy</option><option value="Lusitana">Lusitana</option><option value="Lustria">Lustria</option><option value="Macondo">Macondo</option><option value="Macondo Swash Caps">Macondo Swash Caps</option><option value="Magra">Magra</option><option value="Maiden Orange">Maiden Orange</option><option value="Mako">Mako</option><option value="Mallanna">Mallanna</option><option value="Mandali">Mandali</option><option value="Marcellus">Marcellus</option><option value="Marcellus SC">Marcellus SC</option><option value="Marck Script">Marck Script</option><option value="Margarine">Margarine</option><option value="Marko One">Marko One</option><option value="Marmelad">Marmelad</option><option value="Martel">Martel</option><option value="Martel Sans">Martel Sans</option><option value="Marvel">Marvel</option><option value="Mate">Mate</option><option value="Mate SC">Mate SC</option><option value="Maven Pro">Maven Pro</option><option value="McLaren">McLaren</option><option value="Meddon">Meddon</option><option value="MedievalSharp">MedievalSharp</option><option value="Medula One">Medula One</option><option value="Megrim">Megrim</option><option value="Meie Script">Meie Script</option><option value="Merienda">Merienda</option><option value="Merienda One">Merienda One</option><option value="Merriweather">Merriweather</option><option value="Merriweather Sans">Merriweather Sans</option><option value="Metal">Metal</option><option value="Metal Mania">Metal Mania</option><option value="Metamorphous">Metamorphous</option><option value="Metrophobic">Metrophobic</option><option value="Michroma">Michroma</option><option value="Milonga">Milonga</option><option value="Miltonian">Miltonian</option><option value="Miltonian Tattoo">Miltonian Tattoo</option><option value="Miniver">Miniver</option><option value="Miss Fajardose">Miss Fajardose</option><option value="Modak">Modak</option><option value="Modern Antiqua">Modern Antiqua</option><option value="Molengo">Molengo</option><option value="Molle">Molle</option><option value="Monda">Monda</option><option value="Monofett">Monofett</option><option value="Monoton">Monoton</option><option value="Monsieur La Doulaise">Monsieur La Doulaise</option><option value="Montaga">Montaga</option><option value="Montez">Montez</option><option value="Montserrat">Montserrat</option><option value="Montserrat Alternates">Montserrat Alternates</option><option value="Montserrat Subrayada">Montserrat Subrayada</option><option value="Moul">Moul</option><option value="Moulpali">Moulpali</option><option value="Mountains of Christmas">Mountains of Christmas</option><option value="Mouse Memoirs">Mouse Memoirs</option><option value="Mr Bedfort">Mr Bedfort</option><option value="Mr Dafoe">Mr Dafoe</option><option value="Mr De Haviland">Mr De Haviland</option><option value="Mrs Saint Delafield">Mrs Saint Delafield</option><option value="Mrs Sheppards">Mrs Sheppards</option><option value="Muli">Muli</option><option value="Mystery Quest">Mystery Quest</option><option value="NTR">NTR</option><option value="Neucha">Neucha</option><option value="Neuton">Neuton</option><option value="New Rocker">New Rocker</option><option value="News Cycle">News Cycle</option><option value="Niconne">Niconne</option><option value="Nixie One">Nixie One</option><option value="Nobile">Nobile</option><option value="Nokora">Nokora</option><option value="Norican">Norican</option><option value="Nosifer">Nosifer</option><option value="Nothing You Could Do">Nothing You Could Do</option><option value="Noticia Text">Noticia Text</option><option value="Noto Sans">Noto Sans</option><option value="Noto Serif">Noto Serif</option><option value="Nova Cut">Nova Cut</option><option value="Nova Flat">Nova Flat</option><option value="Nova Mono">Nova Mono</option><option value="Nova Oval">Nova Oval</option><option value="Nova Round">Nova Round</option><option value="Nova Script">Nova Script</option><option value="Nova Slim">Nova Slim</option><option value="Nova Square">Nova Square</option><option value="Numans">Numans</option><option value="Nunito">Nunito</option><option value="Odor Mean Chey">Odor Mean Chey</option><option value="Offside">Offside</option><option value="Old Standard TT">Old Standard TT</option><option value="Oldenburg">Oldenburg</option><option value="Oleo Script">Oleo Script</option><option value="Oleo Script Swash Caps">Oleo Script Swash Caps</option><option value="Open Sans">Open Sans</option><option value="Open Sans Condensed">Open Sans Condensed</option><option value="Oranienbaum">Oranienbaum</option><option value="Orbitron">Orbitron</option><option value="Oregano">Oregano</option><option value="Orienta">Orienta</option><option value="Original Surfer">Original Surfer</option><option value="Oswald">Oswald</option><option value="Over the Rainbow">Over the Rainbow</option><option value="Overlock">Overlock</option><option value="Overlock SC">Overlock SC</option><option value="Ovo">Ovo</option><option value="Oxygen">Oxygen</option><option value="Oxygen Mono">Oxygen Mono</option><option value="PT Mono">PT Mono</option><option value="PT Sans">PT Sans</option><option value="PT Sans Caption">PT Sans Caption</option><option value="PT Sans Narrow">PT Sans Narrow</option><option value="PT Serif">PT Serif</option><option value="PT Serif Caption">PT Serif Caption</option><option value="Pacifico">Pacifico</option><option value="Palanquin">Palanquin</option><option value="Palanquin Dark">Palanquin Dark</option><option value="Paprika">Paprika</option><option value="Parisienne">Parisienne</option><option value="Passero One">Passero One</option><option value="Passion One">Passion One</option><option value="Pathway Gothic One">Pathway Gothic One</option><option value="Patrick Hand">Patrick Hand</option><option value="Patrick Hand SC">Patrick Hand SC</option><option value="Patua One">Patua One</option><option value="Paytone One">Paytone One</option><option value="Peddana">Peddana</option><option value="Peralta">Peralta</option><option value="Permanent Marker">Permanent Marker</option><option value="Petit Formal Script">Petit Formal Script</option><option value="Petrona">Petrona</option><option value="Philosopher">Philosopher</option><option value="Piedra">Piedra</option><option value="Pinyon Script">Pinyon Script</option><option value="Pirata One">Pirata One</option><option value="Plaster">Plaster</option><option value="Play">Play</option><option value="Playball">Playball</option><option value="Playfair Display">Playfair Display</option><option value="Playfair Display SC">Playfair Display SC</option><option value="Podkova">Podkova</option><option value="Poiret One">Poiret One</option><option value="Poller One">Poller One</option><option value="Poly">Poly</option><option value="Pompiere">Pompiere</option><option value="Pontano Sans">Pontano Sans</option><option value="Poppins">Poppins</option><option value="Port Lligat Sans">Port Lligat Sans</option><option value="Port Lligat Slab">Port Lligat Slab</option><option value="Pragati Narrow">Pragati Narrow</option><option value="Prata">Prata</option><option value="Preahvihear">Preahvihear</option><option value="Press Start 2P">Press Start 2P</option><option value="Princess Sofia">Princess Sofia</option><option value="Prociono">Prociono</option><option value="Prosto One">Prosto One</option><option value="Puritan">Puritan</option><option value="Purple Purse">Purple Purse</option><option value="Quando">Quando</option><option value="Quantico">Quantico</option><option value="Quattrocento">Quattrocento</option><option value="Quattrocento Sans">Quattrocento Sans</option><option value="Questrial">Questrial</option><option value="Quicksand">Quicksand</option><option value="Quintessential">Quintessential</option><option value="Qwigley">Qwigley</option><option value="Racing Sans One">Racing Sans One</option><option value="Radley">Radley</option><option value="Rajdhani">Rajdhani</option><option value="Raleway">Raleway</option><option value="Raleway Dots">Raleway Dots</option><option value="Ramabhadra">Ramabhadra</option><option value="Ramaraja">Ramaraja</option><option value="Rambla">Rambla</option><option value="Rammetto One">Rammetto One</option><option value="Ranchers">Ranchers</option><option value="Rancho">Rancho</option><option value="Ranga">Ranga</option><option value="Rationale">Rationale</option><option value="Ravi Prakash">Ravi Prakash</option><option value="Redressed">Redressed</option><option value="Reenie Beanie">Reenie Beanie</option><option value="Revalia">Revalia</option><option value="Rhodium Libre">Rhodium Libre</option><option value="Ribeye">Ribeye</option><option value="Ribeye Marrow">Ribeye Marrow</option><option value="Righteous">Righteous</option><option value="Risque">Risque</option><option value="Roboto">Roboto</option><option value="Roboto Condensed">Roboto Condensed</option><option value="Roboto Mono">Roboto Mono</option><option value="Roboto Slab">Roboto Slab</option><option value="Rochester">Rochester</option><option value="Rock Salt">Rock Salt</option><option value="Rokkitt">Rokkitt</option><option value="Romanesco">Romanesco</option><option value="Ropa Sans">Ropa Sans</option><option value="Rosario">Rosario</option><option value="Rosarivo">Rosarivo</option><option value="Rouge Script">Rouge Script</option><option value="Rozha One">Rozha One</option><option value="Rubik">Rubik</option><option value="Rubik Mono One">Rubik Mono One</option><option value="Rubik One">Rubik One</option><option value="Ruda">Ruda</option><option value="Rufina">Rufina</option><option value="Ruge Boogie">Ruge Boogie</option><option value="Ruluko">Ruluko</option><option value="Rum Raisin">Rum Raisin</option><option value="Ruslan Display">Ruslan Display</option><option value="Russo One">Russo One</option><option value="Ruthie">Ruthie</option><option value="Rye">Rye</option><option value="Sacramento">Sacramento</option><option value="Sahitya">Sahitya</option><option value="Sail">Sail</option><option value="Salsa">Salsa</option><option value="Sanchez">Sanchez</option><option value="Sancreek">Sancreek</option><option value="Sansita One">Sansita One</option><option value="Sarala">Sarala</option><option value="Sarina">Sarina</option><option value="Sarpanch">Sarpanch</option><option value="Satisfy">Satisfy</option><option value="Scada">Scada</option><option value="Scheherazade">Scheherazade</option><option value="Schoolbell">Schoolbell</option><option value="Seaweed Script">Seaweed Script</option><option value="Sevillana">Sevillana</option><option value="Seymour One">Seymour One</option><option value="Shadows Into Light">Shadows Into Light</option><option value="Shadows Into Light Two">Shadows Into Light Two</option><option value="Shanti">Shanti</option><option value="Share">Share</option><option value="Share Tech">Share Tech</option><option value="Share Tech Mono">Share Tech Mono</option><option value="Shojumaru">Shojumaru</option><option value="Short Stack">Short Stack</option><option value="Siemreap">Siemreap</option><option value="Sigmar One">Sigmar One</option><option value="Signika">Signika</option><option value="Signika Negative">Signika Negative</option><option value="Simonetta">Simonetta</option><option value="Sintony">Sintony</option><option value="Sirin Stencil">Sirin Stencil</option><option value="Six Caps">Six Caps</option><option value="Skranji">Skranji</option><option value="Slabo 13px">Slabo 13px</option><option value="Slabo 27px">Slabo 27px</option><option value="Slackey">Slackey</option><option value="Smokum">Smokum</option><option value="Smythe">Smythe</option><option value="Sniglet">Sniglet</option><option value="Snippet">Snippet</option><option value="Snowburst One">Snowburst One</option><option value="Sofadi One">Sofadi One</option><option value="Sofia">Sofia</option><option value="Sonsie One">Sonsie One</option><option value="Sorts Mill Goudy">Sorts Mill Goudy</option><option value="Source Code Pro">Source Code Pro</option><option value="Source Sans Pro">Source Sans Pro</option><option value="Source Serif Pro">Source Serif Pro</option><option value="Special Elite">Special Elite</option><option value="Spicy Rice">Spicy Rice</option><option value="Spinnaker">Spinnaker</option><option value="Spirax">Spirax</option><option value="Squada One">Squada One</option><option value="Sree Krushnadevaraya">Sree Krushnadevaraya</option><option value="Stalemate">Stalemate</option><option value="Stalinist One">Stalinist One</option><option value="Stardos Stencil">Stardos Stencil</option><option value="Stint Ultra Condensed">Stint Ultra Condensed</option><option value="Stint Ultra Expanded">Stint Ultra Expanded</option><option value="Stoke">Stoke</option><option value="Strait">Strait</option><option value="Sue Ellen Francisco">Sue Ellen Francisco</option><option value="Sumana">Sumana</option><option value="Sunshiney">Sunshiney</option><option value="Supermercado One">Supermercado One</option><option value="Sura">Sura</option><option value="Suranna">Suranna</option><option value="Suravaram">Suravaram</option><option value="Suwannaphum">Suwannaphum</option><option value="Swanky and Moo Moo">Swanky and Moo Moo</option><option value="Syncopate">Syncopate</option><option value="Tangerine">Tangerine</option><option value="Taprom">Taprom</option><option value="Tauri">Tauri</option><option value="Teko">Teko</option><option value="Telex">Telex</option><option value="Tenali Ramakrishna">Tenali Ramakrishna</option><option value="Tenor Sans">Tenor Sans</option><option value="Text Me One">Text Me One</option><option value="The Girl Next Door">The Girl Next Door</option><option value="Tienne">Tienne</option><option value="Tillana">Tillana</option><option value="Timmana">Timmana</option><option value="Tinos">Tinos</option><option value="Titan One">Titan One</option><option value="Titillium Web">Titillium Web</option><option value="Trade Winds">Trade Winds</option><option value="Trocchi">Trocchi</option><option value="Trochut">Trochut</option><option value="Trykker">Trykker</option><option value="Tulpen One">Tulpen One</option><option value="Ubuntu">Ubuntu</option><option value="Ubuntu Condensed">Ubuntu Condensed</option><option value="Ubuntu Mono">Ubuntu Mono</option><option value="Ultra">Ultra</option><option value="Uncial Antiqua">Uncial Antiqua</option><option value="Underdog">Underdog</option><option value="Unica One">Unica One</option><option value="UnifrakturCook">UnifrakturCook</option><option value="UnifrakturMaguntia">UnifrakturMaguntia</option><option value="Unkempt">Unkempt</option><option value="Unlock">Unlock</option><option value="Unna">Unna</option><option value="VT323">VT323</option><option value="Vampiro One">Vampiro One</option><option value="Varela">Varela</option><option value="Varela Round">Varela Round</option><option value="Vast Shadow">Vast Shadow</option><option value="Vesper Libre">Vesper Libre</option><option value="Vibur">Vibur</option><option value="Vidaloka">Vidaloka</option><option value="Viga">Viga</option><option value="Voces">Voces</option><option value="Volkhov">Volkhov</option><option value="Vollkorn">Vollkorn</option><option value="Voltaire">Voltaire</option><option value="Waiting for the Sunrise">Waiting for the Sunrise</option><option value="Wallpoet">Wallpoet</option><option value="Walter Turncoat">Walter Turncoat</option><option value="Warnes">Warnes</option><option value="Wellfleet">Wellfleet</option><option value="Wendy One">Wendy One</option><option value="Wire One">Wire One</option><option value="Work Sans">Work Sans</option><option value="Yanone Kaffeesatz">Yanone Kaffeesatz</option><option value="Yantramanav">Yantramanav</option><option value="Yellowtail">Yellowtail</option><option value="Yeseva One">Yeseva One</option><option value="Yesteryear">Yesteryear</option><option value="Zeyada">Zeyada</option>';
var _fonts_sizes = "<option value=''>Default</option>";
var _slide_text_template =
'<div class="slider_text">\
 <div class="value">\
	<table>\
	<tr>\
		<td><label>Title</label></td>\
		<td><input type="text" name="slider_title"/></td>\
	</tr>\
	<!-- <tr>\
		<td><label>Subtitle</label></td>\
		<td><input type="text" name="slider_subtitle"/></td>\
	</tr> -->\
	<tr>\
		<td><label>Description</label></td>\
		<td><textarea name="slider_description"></textarea></td>\
	</tr>\
	</table>\
 </div>\
</div>';		 
var background_style = '';			 

for (var i = 8;i < 65;i++)
{
		_fonts_sizes += "<option value='" + i + "'>" + i + "</option>";
}


function rgb2hex(rgb){
 if (!rgb) return '';
 rgb = rgb.match(/^rgba?[\s+]?\([\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?/i);
 return (rgb && rgb.length === 4) ? "#" +
  ("0" + parseInt(rgb[1],10).toString(16)).slice(-2) +
  ("0" + parseInt(rgb[2],10).toString(16)).slice(-2) +
  ("0" + parseInt(rgb[3],10).toString(16)).slice(-2) : '';
}

var _nico_changes = {};
var _background_backup;

function normalize_string(str)
{
	return str.toLowerCase().replace(/[ -,\.;]/g,'_');
}

var _nico_save_message = "Done";
if (typeof _nico_demo != "undefined" && _nico_demo == true) _nico_save_message = "Saving is disabled in the DEMO version!";

function nico_save_theme()
{
/*	_nico_changes['slider_text'] = {};
	for (l in lang)
	{
		_nico_changes['slider_text'][lang[l]] = {};
		_nico_changes['slider_text'][lang[l]]['title'] = [];
		_nico_changes['slider_text'][lang[l]]['subtitle'] = [];
		_nico_changes['slider_text'][lang[l]]['description'] = [];
		
		var i = -1;
		jQuery("#nico_theme_editor .nico_slide_text.lang_" + [lang[l]]  + " .slider_text input, #nico_theme_editor .nico_slide_text.lang_" + [lang[l]]  + " div.slider_text textarea").each(function ()
		{
			if (this.name == 'slider_title')
			{
				i++;
				if (!_nico_changes['slider_text'][lang[l]][i]) _nico_changes['slider_text'][lang[l]][i] = {};
				_nico_changes['slider_text'][lang[l]][i]['title'] = this.value; 
			} else if (this.name == 'slider_subtitle')
			{
				if (!_nico_changes['slider_text'][lang[l]][i]) _nico_changes['slider_text'][lang[l]][i] = {};
				_nico_changes['slider_text'][lang[l]][i]['subtitle'] = this.value; 
			} else if (this.name == 'slider_description')
			{
				if (!_nico_changes['slider_text'][lang[l]][i]) _nico_changes['slider_text'][lang[l]][i] = {};
				_nico_changes['slider_text'][lang[l]][i]['description'] = this.value; 
			}
		});
   }
   
	var menu = [];
	function processOneLi(node) {       
		if (node.hasClass("categories"))
		{
			 var retVal = {
				"categories": true,
			}
		} else
		{
			var retVal = {};
			jQuery("> div > input", node).each(function() 
			{
				var $this = jQuery(this);
				var name = $this.attr("name");
				var val = $this.val();
				if (name == 'url' && val != '' ) retVal['url'] = $this.val();
				else
				{
				    if (!retVal['text']) retVal['text'] = {};
				    if (val != '') retVal['text'][name] = val;
				}
			});
		}
		
		node.find("> ul > li").each(function() {
			if (!retVal.hasOwnProperty("children")) {
				retVal.children = [];
			}
			retVal.children.push(processOneLi($(this)));
		});
		return retVal;
	}
	$("#nico_menu ul.jstree-no-dots > li").each(function() {
		menu.push(processOneLi($(this)));
	});

	_nico_changes['menu'] = menu;
*/
	var path = document.location.pathname;
	if (typeof path == "undefined") path = "";

	jQuery(".nico_status").text("Saving ...").show()
	$.ajax({
	  type:"POST",
	  url: path,
	  data:_nico_changes,
	  context: document.body
	}).done(function() { 
		var queryString = '?reload=' + new Date().getTime();
		
		$('link[rel="stylesheet"]._editor_css').attr("href", function () 
		{ 
			return this.href.replace(/\?.*|$/, queryString);
		});
		jQuery(".nico_status").text(_nico_save_message).show()
		
		_nico_changes = {};
		_nico_changes['styles'] = {};
		setTimeout('jQuery(".nico_status").text("").hide();', 2000);
	});		
}	

function init_backgrounds()
{
		jQuery("#nico_theme_editor .pattern .value").hover(
		  function (e) 
		  {
			var body = jQuery("body");
			var $this = jQuery(this);

			_background_backup = body.attr('style');
			//jQuery(".page-container body").css('background-image', $this.css('background-image'));
			jQuery("body").attr("style",$this.attr('style') + ';background-size:auto;' + background_style);
		  }, 
		  function (e) 
		  {
			var body = jQuery("body");
			jQuery("body").attr('style', _background_backup + ';background-size:auto;' + background_style);
		  }
		).click(function (e)
		{
			var body = jQuery("body");
			var $this = jQuery(this);
			jQuery("#nico_theme_editor .pattern .value").removeClass("selected");
			_nico_changes['background-image'] = _background_backup = $this.addClass("selected").attr('style');
			//console.log(_nico_changes['background-image']);
			jQuery("body").attr("style",_nico_changes['background-image'] + ';background-size:auto;' + background_style);
		});
		
		jQuery("#nico_theme_editor #background-style").on("change", function() 
		{
			_nico_changes['background-style'] = this.value;
			switch(this.value)
			{
					case 'repeat':
						background_style = 'background-repeat:repeat';
					break;
					case 'repeat-x':
						background_style = 'background-repeat:repeat-x';
					break;
					case 'repeat-y':
						background_style = 'background-repeat:repeat-y';
					break;
					case 'stretch':
						background_style = 'background-size:100%;background-size:cover';
					break;
					case 'no-repeat':
						background_style = 'background-repeat:no-repeat';
			}
			
			jQuery("body").attr("style",'background-image:' + _background_backup + ';background-size:auto;' + background_style);
		});
			
}

function init_colors()
{
	
		var picker_options =
		{
			parts:['map', 'bar', 'hex', 'hsv', 'rgb', 'alpha', 'preview'],
			alpha: true,
			inline:false,
			buttonColorize: true,
			showNoneButton: true,
			colorFormat: 'RGBA',
			color:"#ffffff",
			mode:"r",
			select:	function(event, color) 
			{
				var element = $(this);
				element.css('backgroundColor', color.formatted);
				jQuery(element.attr("data-selector")).css(element.attr("data-attribute"), color.formatted);

				if (!_nico_changes["colors"]) _nico_changes["colors"] = {};
				if (!_nico_changes["colors"][element.attr("data-selector")]) _nico_changes["colors"][element.attr("data-selector")] = {};
				if (color.formatted) _nico_changes['colors'][element.attr("data-selector")][element.attr("data-attribute")] = color.formatted;
			}
		};
	
		jQuery("#nico_theme_editor .color").each(function() 
		{
			var element = jQuery(".value", this);
			var back_color = "";
			back_color = element.attr("data-default");
			if (back_color == "") back_color = jQuery(element.attr("data-selector")).css(element.attr("data-attribute"));
			
			if (typeof back_color != "undefined" && back_color.charAt(0) != "#") back_color = rgb2hex(back_color);
			
			element.css({backgroundColor:back_color});
			picker_options.color = back_color;
			
			$(element).colorpicker(picker_options);
		});
}

function init_fonts()
{
		jQuery("#nico_theme_editor ._font_select").each(function() 
		{
			var element = jQuery(this);
			element.html(_fonts);
			var font_family = element.attr("data-default");
			if (!font_family) font_family = jQuery(element.attr("data-selector")).css("font-family");
			if (!font_family) font_family = '';
			font_family = font_family.substr(0,font_family.indexOf(",")).replace(/["',]/g,'').trim();
			element.val(font_family);
				/*var element = $(this);
				jQuery(element.attr("data-selector")).css({fontFamily:this.value});*/
		});
		
		jQuery("#nico_theme_editor ._font_select_size").each(function() 
		{
			var element = jQuery(this);
			element.html(_fonts_sizes);

			var font_size = element.attr("data-default");
			if (!font_size) font_size = jQuery(element.attr("data-selector")).css("font-size");
			
			element.val(parseInt(font_size));
				/*var element = $(this);
				jQuery(element.attr("data-selector")).css({fontFamily:this.value});*/
		});

		
		jQuery("#nico_theme_editor ._font_select").on("change", function() 
		{
				var element = $(this);
				if (jQuery("._font_" + this.value).length == 0)
				{
					var font = normalize_string(this.value);
					$('body').append('<link class="_font_' + this.value + '" rel="stylesheet" href="https://fonts.googleapis.com/css?family=' + this.value + '" type="text/css" />');
				}			

				jQuery(element.attr("data-selector")).css({fontFamily:this.value});
				
				if (!_nico_changes["fonts"]) _nico_changes["fonts"] = {};
				if (!_nico_changes["fonts"][element.attr("data-selector")]) _nico_changes["fonts"][element.attr("data-selector")] = {};				
				_nico_changes['fonts'][element.attr("data-selector")]['font-family'] = this.value;

/*				if (!_nico_changes["fonts"]) _nico_changes["fonts"] = {};
				_nico_changes['fonts'][element.attr("data-selector")] = this.value;*/
		});
		
		jQuery("#nico_theme_editor ._font_select_size").on("change", function() 
		{
				var element = $(this);
				jQuery(element.attr("data-selector")).css({fontSize:this.value + "px"});
				
				if (!_nico_changes["fonts"]) _nico_changes["fonts"] = {};
				if (!_nico_changes["fonts"][element.attr("data-selector")]) _nico_changes["fonts"][element.attr("data-selector")] = {};				
				_nico_changes['fonts'][element.attr("data-selector")]['size'] = this.value;
		});
}

var _backgrounds_first_load = true;
var _colors_first_load = true;
var _fonts_first_load = true;

function init_editor()
{
	$(".nico_tab").eq(0).show();
	
	jQuery("#nico_save_settings").on("click", function(e) 
		{
			if (_nico_changes)
			{
				_nico_changes["_nico_save_theme"] = true;
				nico_save_theme();
				
			} else
			{
				alert("Nothing to save, make some changes first");	
			}
			e.preventDefault();
			return false;
		});
		
		jQuery("#nico_reset").on("click", function(e) 
		{
			_nico_changes["_nico_reset_theme"] = true;
			nico_save_theme();
			e.preventDefault();
			return false;
		});
		
	
		$(".nico_tabs li").click(function(e) 
		{
			e.preventDefault();
			
			if (_backgrounds_first_load && this.innerHTML == "Background")
			{
				jQuery(".nico_status").text("Loading background patterns ...").show();
				_backgrounds_first_load = false;
				 $(".nico_tab > div").hide();
				 window.setTimeout(function() 
				 {
					init_backgrounds();
					$(".nico_tab > div").show();
					jQuery(".nico_status").text("").hide();
				}, 100);
			}
			if (_colors_first_load && this.innerHTML == "Colors")
			{
				jQuery(".nico_status").text("Loading colors ...").show();
				_colors_first_load = false;
				 window.setTimeout(function() 
				 {
					init_colors();
					jQuery(".nico_status").text("").hide();
				}, 100);
			}
			if (_fonts_first_load && this.innerHTML == "Fonts")
			{
				jQuery(".nico_status").text("Loading fonts ...").show();
				_fonts_first_load = false;
				 window.setTimeout(function() 
				 {
					init_fonts();
					jQuery(".nico_status").text("").hide();
				}, 100);
			}		  
			
		  var index = $(".nico_tabs li").removeClass("selected").index(this);
		  $(this).addClass("selected");
		  $(".nico_tab").hide().eq(index).show();
		});
		
		
		$(".nico_slide_text li").click(function(e) 
		{
		  var index = $(".nico_slide_text li").removeClass("selected").index(this);
		  $(this).addClass("selected");
		  $("div.nico_slide_text").hide().eq(index).show();
		});
		
		$("div.nico_slide_text").eq(0).show();
			
		jQuery("#nico_theme_editor .setting .value input[type=text]").on("keyup", function() 
		{
				var element = $(this);
				var attribute = element.attr("data-attribute");
				if (attribute == 'text')
				{
					jQuery(element.attr("data-selector")).text(this.value);
				} else
				{
					jQuery(element.attr("data-selector")).attr(attribute, this.value);
				}
				
				if (!_nico_changes["settings"]) _nico_changes["settings"] = {};
				_nico_changes['settings'][element.attr("name")] = this.value;
		});
		
		jQuery("#nico_theme_editor .setting .value input[type=checkbox]").on("change", function() 
		{
				var element = $(this);
				var attribute = element.attr("data-attribute");
				if (attribute == 'text')
				{
					jQuery(element.attr("data-selector")).text(this.value);
				} else
				{
					jQuery(element.attr("data-selector")).attr(attribute, this.value);
				}
				
				if (!_nico_changes["settings"]) _nico_changes["settings"] = {};
				_nico_changes['settings'][element.attr("name")] = this.checked;
		});
		
				
		jQuery("#nico_theme_editor .setting .value textarea, #nico_theme_editor .setting .value select").on("change", function() 
		{
				var element = $(this);
				var attribute = element.attr("data-attribute");
				if (attribute == 'text')
				{
					jQuery(element.attr("data-selector")).text(this.value);
				} else
				{
					jQuery(element.attr("data-selector")).attr(attribute, this.value);
				}
				
				if (!_nico_changes["settings"]) _nico_changes["settings"] = {};
				_nico_changes['settings'][element.attr("name")] = this.value;
		});
		
		/* ---- */
		jQuery("#nico_theme_editor .slider .value input[type=text]").on("keyup", function() 
		{
				var element = $(this);
				var attribute = element.attr("data-attribute");
				var page = element.attr("data-page");
				var slider = element.attr("data-slider");
				
				if (attribute == 'text')
				{
					jQuery(element.attr("data-selector")).text(this.value);
				} else
				{
					jQuery(element.attr("data-selector")).attr(attribute, this.value);
				}
				
				if (!_nico_changes["sliders"]) _nico_changes["sliders"] = {};
				if (!_nico_changes["sliders"][page]) _nico_changes["sliders"][page] = {};
				if (!_nico_changes["sliders"][page][slider]) _nico_changes["sliders"][page][slider] = {};
				
				_nico_changes['sliders'][page][slider][element.attr("data-_name")] = this.value;
		});
				
		jQuery("#nico_theme_editor .label_option input[type=radio], #nico_theme_editor .slider .value input[type=checkbox], #nico_theme_editor .slider .value input[type=radio]").on("change", function() 
		{
				var element = $(this);
				var attribute = element.attr("data-attribute");
				var page = element.attr("data-page");
				var slider = element.attr("data-slider");
				
				if (attribute == 'text')
				{
					jQuery(element.attr("data-selector")).text(this.value);
				} else
				{
					jQuery(element.attr("data-selector")).attr(attribute, this.value);
				}
				
				if (!_nico_changes["sliders"]) _nico_changes["sliders"] = {};
				if (!_nico_changes["sliders"][page]) _nico_changes["sliders"][page] = {};
				if (slider && !_nico_changes["sliders"][page][slider]) _nico_changes["sliders"][page][slider] = {};
				
				var value = '';
				if (this.type == "checkbox") value = this.checked; else value = this.value;
				if (!slider) _nico_changes['sliders'][page]['active'] = this.value;
				else _nico_changes['sliders'][page][slider][element.attr("data-_name")] = value;
		});
		
		jQuery("#nico_theme_editor .slider .value select").on("change", function() 
		{
			var element = jQuery(this);
			var page = element.attr("data-page");
			var slider = element.attr("data-slider");			
			
			if (!_nico_changes["sliders"]) _nico_changes["sliders"] = {};
			if (!_nico_changes["sliders"][page]) _nico_changes["sliders"][page] = {};
			if (!_nico_changes["sliders"][page][slider]) _nico_changes["sliders"][page][slider] = {};
				
			_nico_changes['sliders'][page][slider][element.attr("data-_name")] = element.val();
		});
		
				
		jQuery("#nico_theme_editor .slider .value textarea").on("change", function() 
		{
				var element = $(this);
				var attribute = element.attr("data-attribute");
				var page = element.attr("data-page");
				var slider = element.attr("data-slider");
				
				if (attribute == 'text')
				{
					jQuery(element.attr("data-selector")).text(this.value);
				} else
				{
					jQuery(element.attr("data-selector")).attr(attribute, this.value);
				}
				
				if (!_nico_changes["sliders"]) _nico_changes["sliders"] = {};
				if (!_nico_changes["sliders"][page]) _nico_changes["sliders"][page] = {};
				if (!_nico_changes["sliders"][page][slider]) _nico_changes["sliders"][page][slider] = {};
				
				_nico_changes['sliders'][page][slider][element.attr("data-_name")] = this.value;
		});
				
		
		/*jQuery("#nico_theme_editor .option select.value").each(function() 
		{
			var element = jQuery(this);
			element.val(jQuery(element.attr("data-selector")).css(element.attr("data-attribute")));
		});*/
					
		jQuery("#nico_theme_editor .option select.value").on("change", function() 
		{
			var element = jQuery(this);
			jQuery(element.attr("data-selector")).css(element.attr("data-attribute"), this.value);
			
			if (!_nico_changes["options"]) _nico_changes["options"] = {};
			if (!_nico_changes["options"][element.attr("data-selector")]) _nico_changes["options"][element.attr("data-selector")] = {};				
			_nico_changes['options'][element.attr("data-selector")][element.attr("data-attribute")] = this.value;
		});
		
		
		_nico_changes['styles']= {};
		var _css_backup = {};
		jQuery("#nico_theme_editor .style .value").hover(
		  function (e) 
		  {
			var $this = jQuery(this);  
			var group = $this.attr("data-group");
			var css = jQuery('#_style_css_' + group);
			var css_file =  $this.attr("data-css");
			
			if (css.length)
			{
				_css_backup[group] = css.attr("href");
				css.attr("href", css_file);
			} else
			{	
				_css_backup[group] = '';
				$('body').append('<link id="_style_css_' + group + '" rel="stylesheet" href="' + css_file + '" type="text/css" />');			  
			}
			  
		  }, 
		  function (e) 
		  {
			var $this = jQuery(this);  
			var group = $this.attr("data-group");
			var css = jQuery('#_style_css_' + group);

			css.attr("href", _css_backup[group]);
		  }
		).click(function (e)
		{
			var $this = jQuery(this);  
			var group = $this.attr("data-group");
			var css = jQuery('#_style_css_' + group);
			var css_file =  $this.attr("data-css");
			var file =  $this.attr("data-file");
			
			css.attr("href", css_file);
			_css_backup[group] = css_file;
			_nico_changes['styles'][group] = file;
			
			jQuery("#nico_theme_editor .style .value." + group).removeClass("selected");
			$this.addClass("selected")
		});
}

var _scroll_timer;
function nico_import_start()
{
	if (_nico_demo)
	{
		jQuery(".nico_status").text(_nico_save_message).show()
		
		_nico_changes = {};
		_nico_changes['styles'] = {};
		setTimeout('jQuery(".nico_status").text("").hide();', 2000);
		return;
	}
	
	$('#import_modal .modal-body').html('<iframe style="width:100%;" frameborder="0" src="index.php?route=module/nicoimport&' + jQuery(".nico_import_tab input, .nico_import_tab select").serialize() + '&rand=' + Math.random() + '"></iframe>');
	$('#import_modal').modal('toggle');
	
	$('#import_modal iframe').load(function () 
	{
		var $contents = $('#import_modal iframe').contents();
		if ($contents.length)
		$contents.scrollTop($contents.height());
		clearInterval(_scroll_timer);
	});
	
	_scroll_timer = setInterval(function ()
	{
			var $contents = $('#import_modal iframe').contents();
			if ($contents.length)
			$contents.scrollTop($contents.height());
	}, 500);


	/*
	jQuery(".nico_status").text('Initializing data import ...').show();
	$.ajax({
	  type:"POST",
	  dataType: "jsonp",
	  url: store_path,
	  context: document.body
	}).done(function(data) 
	{ 
		if (data.error) 
		{
			jQuery(".nico_status").text("").hide();

			$('#import_modal .modal-body').html('<h1>' + data.error + '</h1>');
			$('#import_modal').modal('toggle');

			if (data.import)
			{
				nico_import();
			}
		}
	});*/	
}

function nico_import()
{
	jQuery(".nico_status").text("").hide();
	$('#import_modal').modal('toggle');
	message = $('#import_modal .modal-body');

	message.append('<div>Purchase code ok</div><div><strong>Importing modules</strong></div><div>Nico custom products</div>');
	
	 var last_response_len = false;
		$.ajax('catalog/view/theme/x-shop/nico_theme_editor/import.php', {
			xhrFields: {
				onprogress: function(e)
				{
					var this_response, response = e.currentTarget.response;
					if(last_response_len === false)
					{
						this_response = response;
						last_response_len = response.length;
					}
					else
					{
						this_response = response.substring(last_response_len);
						last_response_len = response.length;
					}
					
					message.append(this_response);
					//console.log(this_response);
					height = message[0].scrollHeight;
					message.scrollTop(height);
				}
			}
		})
		.done(function(data)
		{
			message.append('Import finished: ' + data);
			//console.log('Import finished: ' + data);
		})
		.fail(function(data)
		{
			//console.log('Error: ', data);
			message.append('Error: ' + data);
		});
		
		message.append('Download started');

	
}


jQuery(document).ready(function()
{
		var _first_load = true;
		$("#show_hide_editor").on("click", function (e) 
		{
			var editor = jQuery("#nico_theme_editor");
			if (editor.css("height") == '0px')
			{
				jQuery(this).addClass("close").html('');
				jQuery("body").css("marginBottom", "300px");
				editor.animate({height:"300px"},500, function() { $("#show_hide_editor").fadeIn();});
				$.cookie('editor', 'true');
				if (_first_load)
				{
					_first_load = false;
					
					/*if (!is_writable || !is_writable_css) 
					{
								jQuery(".nico_status").html("<p>File <strong>/nico_theme_editor/settings.inc</strong> and <strong>/nico_theme_editor/editor_settings.css</strong> is not writable by php, <strong>saving will not work</strong>.<br>Set proper permission to make the file writable by php, 0766 if unsure.<br/>Check theme docs for more info.</p>").show();
								setTimeout('jQuery(".nico_status").text("").hide();', 20000);
					}
					*/
					init_editor();
				}
			} else
			{
				jQuery(this).removeClass("close").html('<i class="fa fa-gears"></i>&ensp;Customize theme');
				jQuery("body").css("marginBottom", "0px");
				editor.animate({height:"0px"},500, function() { $("#show_hide_editor").fadeIn();});
				$.cookie('editor', 'false');
			}
			
			e.preventDefault();
			return false;
		});
		if ($.cookie('editor') == "true" || location.hash == "#nico_customize_theme"/* || (_nico_demo == true && $.cookie('editor') == null)*/) $("#show_hide_editor").click();
		
		
		//slider accordion
		$('.nico_tab.sliders div .label_option').click(function() {
			var $parent = this.parentNode;
			var $container = $(this).next();
			jQuery('> div.slider_container', $parent).not($container).slideUp('normal');
			$container.slideDown('normal');
		});
	 
	 
	 
		jQuery("#nico_zoom_bottomscreen").click(function(e) 
		{
			var editor = jQuery("#nico_theme_editor");
			var show_hide_editor = jQuery("#show_hide_editor");
			var prev_height = jQuery(".nico_tab").height();
			var height = 255;
			
			editor.animate({height:"300px"},500, function() 
			{ 
				if (prev_height > height)
				{
					jQuery(".nico_tab").css({height:height + "px"});					
				}
			});

			if (prev_height <= height)
			{
				jQuery(".nico_tab").css({height:height + "px"});					
			}
			
			//show_hide_editor.css({marginTop:"-50px",paddingBottom:"50px", opacity:"1", display:"none"}).text("Customize theme");
			editor.animate({height:"300px"},500);
			
			e.preventDefault();
			return false;
		});


		jQuery("#nico_zoom_halfscreen").click(function(e) 
		{
			var editor = jQuery("#nico_theme_editor");
			var prev_height = jQuery(".nico_tab").height();
			var height = ($(window).height() / 2) -45;
			
			editor.animate({height:"50%"},500, function() 
			{ 
				if (prev_height > height)
				{
					jQuery(".nico_tab").css({height:height + "px"});					
				}
			});

			if (prev_height <= height)
			{
				jQuery(".nico_tab").css({height:height + "px"});					
			}


			e.preventDefault();
			return false;
		});



		jQuery("#nico_zoom_fullscreen").click(function(e) 
		{
			var editor = jQuery("#nico_theme_editor");
			var prev_height = jQuery(".nico_tab").height();			
			var height = ($(window).height()) -45;
			
			editor.animate({height:"98%"},500, function() {
				if (prev_height > height)
				{
					jQuery(".nico_tab").css({height:height + "px"});					
				}
			});
			
			if (prev_height < height)
			{
				jQuery(".nico_tab").css({height:height + "px"});					
			}
			
			e.preventDefault();
			return false;
		});
/*		
		jQuery(".nico_add_slide").click(function (e)
		{
			e.preventDefault();
			var lang = this.getAttribute("lang");
			jQuery("div.nico_slide_text.lang_" + lang).append(_slide_text_template.replace("slider_text","slider_text lang_" + lang));
			return false;
		});
		
		jQuery(".nico_remove_slide").click(function (e)
		{
			e.preventDefault();
			var lang = this.getAttribute("lang");
			jQuery("div.nico_slide_text.lang_" + lang + " .slider_text:last-child").remove();
			return false;
		});
		
		var tree = $("#nico_menu");
		
	
		jQuery("#nico_menu").on("click", ".remove", function() {
			var node = this.parentNode.parentNode;
			if (confirm("Are you sure you want to remove this menu item and all it's submenus?") && tree.jstree("remove", node))
			{
			}
		});
		
		jQuery("#nico_menu").on("click", ".add_subcat", function() {
			jQuery("a", node).removeClass("jstree-clicked");

			var node = this.parentNode.parentNode;
			tree.jstree("create", node, "last","Menu item",  
				function(obj, name) {
					var clone = jQuery(".nico_new_menu_item_template").clone().attr("class","");
					jQuery("a",obj).addClass("jstree-clicked").after(clone);
					jQuery("input[name="+ current_lang + "]", obj).focus();
				}, true);
				
			return false;
		});
		
		jQuery(".nico_menu").on("click", "#nico_add_menu_item",function() 
		{
				jQuery(".jstree-clicked").removeClass("jstree-clicked");
				tree.jstree("create", -1, "last","Menu item",  
				function(obj, name) {
					var clone = jQuery(".nico_new_menu_item_template").clone().attr("class","");
					jQuery("a",obj).addClass("jstree-clicked").after(clone);
					jQuery("input[name="+ current_lang + "]", obj).focus();
				}, true);
				
				return false;
		});		
		
		jQuery(".nico_menu").on("click", "#nico_add_ocmenu_item",function() 
		{
				jQuery(".jstree-clicked").removeClass("jstree-clicked");
				tree.jstree("create", -1, "last","Opencart categories",  
				function(obj, name) {
					jQuery(obj).addClass("categories");;
					var clone = jQuery(".nico_new_menu_item_template").clone().attr("class","");
					jQuery("a",obj).addClass("jstree-clicked").after(clone);
					jQuery("input[name="+ current_lang + "]", obj).focus();
				}, true);
				
				return false;
		});			

		$("#nico_menu").jstree({"plugins" : [ "themes", "html_data", "cookie", "ui", "dnd", "crrm" ],
					"themes" : {
					"theme" : "default",
					"dots" : false}});
		
		jQuery("#nico_menu").on("keyup", "input[name="+ current_lang + "]", function (e) {jQuery(".jstree-clicked ins").get(0).nextSibling.textContent = this.value});*/
});
