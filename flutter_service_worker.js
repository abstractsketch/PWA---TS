'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "e8d86b7d589a603a6c929ef86dbbb28a",
".git/config": "2928a8a8ab2adedd91b4221c56cf9215",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "60f7ce7199e5469a01bd15eec0ea247a",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "eeb2d7cebc60db266b026320cd438273",
".git/logs/refs/heads/main": "eeb2d7cebc60db266b026320cd438273",
".git/logs/refs/remotes/origin/gh-pages": "33e2cffe9e2f3648092c29b27dce5693",
".git/objects/08/27c17254fd3959af211aaf91a82d3b9a804c2f": "360dc8df65dabbf4e7f858711c46cc09",
".git/objects/08/8288fa3fb36ee2415a435e297f61b64c1eed50": "d427c8edf7a506a6c6c97a9d81d13efc",
".git/objects/0f/0f7ef76d1e5be51433cadad6f3e8edcd8978e1": "62fe048053c3ee2419ced01762d0b167",
".git/objects/10/9e09162ca13a58688826bdba02799a2807377e": "1cbece680724604d8d9a5827bdb62a2d",
".git/objects/18/aed645ed60d9e0bf604f527f88e4e327df5836": "1eaf375d4e7bc7d567d299331ede2249",
".git/objects/18/c4ff1beca922ae72aab3fe7b9da58f4d8b0ede": "fd1b9bcc4d899594bec90bebd8e5b7a0",
".git/objects/19/88df0845bf32fabea389361824b6536fe0cdac": "17a38c8fa498ef00ee490a7ee4693d63",
".git/objects/1a/320597a6c7fe336594c429ab6f3738295106ae": "02dc44bd995f059b1c6edd9fb055a5ce",
".git/objects/1e/5175402cdc5018d57b00321ccbe5e64d4c953e": "d795cff17307837077a415d0646b20cb",
".git/objects/22/5744bd6947df637fa2f5dbcc5e7c0dea0a6aa1": "9a92957b4a8b60d7f510b1a0baaae628",
".git/objects/25/b24861f911498a4abf529e637c7ad776adf8a0": "1d425612cb077a83a513039daf67b2fd",
".git/objects/27/a21b22b64275f06ba001cb2f4c5600ce115f56": "3dfb44bf86e3f6fa004bb039204b7fb3",
".git/objects/2a/c46f2b761e0d567d8d8d01540f87e5e3c4eb81": "0efa3f0dddae29d200219d2223922a7d",
".git/objects/2c/4fb6cbd7e72501fc6ab1ea3725349867d6b93e": "64dad109e97452a76425225887e704ad",
".git/objects/3a/1b54b90adf47d0883017d53e4ffca7e826804e": "15e95886d4bd6ad13ebb475286fda0f1",
".git/objects/3a/8cda5335b4b2a108123194b84df133bac91b23": "1636ee51263ed072c69e4e3b8d14f339",
".git/objects/40/fc6418c51d496cbbfb3c4351070b083a527cb0": "69b2f4a0d2024f3e8f2c5f89c94beaa5",
".git/objects/45/45b8eaf094b432e53b551486b4dbcd4586844d": "ae8553488dfce048a2bf9bf1333cda81",
".git/objects/47/732f80e23bad2fa935a3046a56088b5a73ddee": "254b3876b10cb9a60351d9c110663790",
".git/objects/4f/40dabe4430b4d7288c6ae92d8fc3e17cf8e410": "7c1843130f2c3787540ded5445c7793a",
".git/objects/50/de41c8315c248a4b380111aeb4d8faa5ac5a40": "b8583ff2d9af57a0745d7845cf867d55",
".git/objects/51/03e757c71f2abfd2269054a790f775ec61ffa4": "d437b77e41df8fcc0c0e99f143adc093",
".git/objects/51/ac868d2e4ae1bd595259ed84b7b017381d96cb": "ba2f43323ba13940fda45e34aac637b4",
".git/objects/53/dd4a9679b55171ce57875458cb582418c5e44d": "fcd638367c2aaaaf20abbc9b2858cdc3",
".git/objects/5c/a017893b2927c9a549a678278c883a97ef2a0d": "ae6097befff3fad1d76396cd065264d6",
".git/objects/68/43fddc6aef172d5576ecce56160b1c73bc0f85": "2a91c358adf65703ab820ee54e7aff37",
".git/objects/69/7612b856b42c7df2f6b11a751697ce3fb59ba5": "eb2c167bd5d2090211aac5d103a33a2d",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/6f/7661bc79baa113f478e9a717e0c4959a3f3d27": "985be3a6935e9d31febd5205a9e04c4e",
".git/objects/72/af2ffe45b736742040315b5362ac421e9b7702": "d621e6a0893adf131a4cf7a08ea6a724",
".git/objects/72/d2ac11e3a7e709db33c98612eb36324b65a1c5": "c79df3f24627348b03a122af4e1edf89",
".git/objects/75/42c6b0e9cdcf9c8e3f7da12ab5edf7415f9fad": "f31e0e5a82c78b71792ba19b15f96867",
".git/objects/75/940ac3ec8e966b61b63d3c40c33ac0b2fcc922": "b1dd7938b154cec84e520eb55fe5b306",
".git/objects/78/a7a927f63609d8bd0ebba837e46f42fe910025": "2e2996645030f8d4ae063311c7fbdee8",
".git/objects/79/0dcf0b839d0fd9fd671714414d05a9b31f4263": "96665b810eb504ff78590df72866a894",
".git/objects/7c/3463b788d022128d17b29072564326f1fd8819": "37fee507a59e935fc85169a822943ba2",
".git/objects/82/039646eae58381941a128edf3dd254c98a2961": "ba71a4099c57c699fe2ac9b609735b8e",
".git/objects/85/63aed2175379d2e75ec05ec0373a302730b6ad": "997f96db42b2dde7c208b10d023a5a8e",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8e/21753cdb204192a414b235db41da6a8446c8b4": "1e467e19cabb5d3d38b8fe200c37479e",
".git/objects/8e/e169f5a8777b4c5b36e093ff807856b040e211": "7e76592fb880f76b6eb6d2f26ef343c8",
".git/objects/8f/692ca12a01dd92a49440c546f16ddcc12f5ef9": "21aa95dac461ced15f4b26e9e802eb3c",
".git/objects/93/b363f37b4951e6c5b9e1932ed169c9928b1e90": "c8d74fb3083c0dc39be8cff78a1d4dd5",
".git/objects/94/971234edf8a330a4577acedd3e03b01d190a66": "7288b28358cdbb323099c433ebb72ab6",
".git/objects/94/bbcd7fae52d975906cf45d901d521686581f19": "85b3c557193226541228296ebb2a1e1d",
".git/objects/94/cbfac7ac88f9b6779eb7202a6b3248b00dafd8": "e2ab92759fa7e0b2a7e6528156dd562c",
".git/objects/9c/180e753efcce5ce4a410ee031109ef75065691": "79e7d05f1b9320df7d5aaf3f6e1abc08",
".git/objects/a7/3f4b23dde68ce5a05ce4c658ccd690c7f707ec": "ee275830276a88bac752feff80ed6470",
".git/objects/ad/ced61befd6b9d30829511317b07b72e66918a1": "37e7fcca73f0b6930673b256fac467ae",
".git/objects/b1/d9a988ba98f457908e1ea123e1fe2ce4fb4bf5": "f6a77a7bf22c20afeb60b7d7193ec2d9",
".git/objects/b5/7a25bd396b161f1fc255618a06b0ed7c2ff488": "340a474c138154c80acb8b6a16468934",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/3e39bd49dfaf9e225bb598cd9644f833badd9a": "666b0d595ebbcc37f0c7b61220c18864",
".git/objects/c3/944b8a86e8e765015d9f823da8321bc425b40f": "00f2a42df0979a2759e789cb2c87b344",
".git/objects/c5/55646c8696269f9327111413bc8f710a93242e": "145b964f335c955c7e24db717b2263b6",
".git/objects/c8/3af99da428c63c1f82efdcd11c8d5297bddb04": "144ef6d9a8ff9a753d6e3b9573d5242f",
".git/objects/cf/5cb2713d786db400656421911a668ccca0799e": "662c43f22307a84b8e591cd2d789142f",
".git/objects/d0/863644eb85244440f205b2948985fc908142f5": "7ce52360349ea6a07a0ef874607e50b5",
".git/objects/d2/0c61c4abe5876d1ae512ea0edbbf9538c3e162": "1fd875898528c6dff4676a30c6a5838c",
".git/objects/d3/2cb65c25a8ca0df24b663223bd7755c17f36fb": "ee27b971802afc57efd1301bf1cd8898",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d5/95e2806a069a8b6863d5e1755e5d37ebaeb538": "26999ce129cbca9064b7435a1331ee72",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d9/5b1d3499b3b3d3989fa2a461151ba2abd92a07": "a072a09ac2efe43c8d49b7356317e52e",
".git/objects/db/6e8e438d3c8aaef8fcc0bd7a4adbf0bc9eb635": "c7561ee280d823c21de55b929e418061",
".git/objects/e2/4796d812c4e5c97cec0783fb9c0f910c0fb591": "26e23fca776466bec9a26a9e48f8db5b",
".git/objects/e2/5568d21d889ceb25dec0e353629f72438d524b": "7f25146718d724eb8a02699f96a97af0",
".git/objects/e3/893d874f83726c7faee6b44a20e3f501a947cf": "018c2070207c5adf1a0677acd0bd09fc",
".git/objects/e4/ed235292217bcdfed3c881742e8797415719b5": "65c13407454354e59faf7cdb37ee760c",
".git/objects/e9/1db7fe61df88f5392d0201c7587613c41b4f38": "545f4c4b6dd139eda6524b7151c2b1ce",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/ea/28c94afb06beaab18d6a0a54c584be67ad3d8f": "c15b568a1e95e1ed4169b1c47fe69deb",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ec/1b40267b7a70625e664eb7153afd8284d72ea0": "35918205877e00d670bba51d5aac95ea",
".git/objects/ec/5dded51172808545accaab88a3c0d33a5689d1": "09b482b80794bf528a7c94c73f303228",
".git/objects/f3/3e0726c3581f96c51f862cf61120af36599a32": "afcaefd94c5f13d3da610e0defa27e50",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/f5/90f0b39f6df550d90d12774b290109b0bfabe9": "fa35a66c8140012644d88ce2881aa340",
".git/objects/f6/e6c75d6f1151eeb165a90f04b4d99effa41e83": "95ea83d65d44e4c524c6d51286406ac8",
".git/objects/fb/302c9efb0724f1b99f2fbc59d9f9e39e3de515": "c4d61ac9f6ad889ac936c46985f30afc",
".git/objects/fc/b9565effad379c292771c54c7396103e377227": "4702cc4e0be35e6597d413e17fd072b0",
".git/objects/fd/05cfbc927a4fedcbe4d6d4b62e2c1ed8918f26": "5675c69555d005a1a244cc8ba90a402c",
".git/refs/heads/main": "014631a91946e0c7bed3058466771690",
".git/refs/remotes/origin/gh-pages": "014631a91946e0c7bed3058466771690",
"assets/AssetManifest.bin": "64351d9524e4b9eb660de85c36b5a227",
"assets/AssetManifest.bin.json": "52069fabf884d8fbb5cb3ba9f4107ded",
"assets/assets/audios/Meditation1.mp3": "a8fa1568c20c39da8b9e1ff1e58c8eef",
"assets/assets/audios/Regen.mp3": "f9ef20ac39bb5fea240a3c1290805864",
"assets/assets/bilder/berge.jpg": "f4ce8e607cd9bf5889a749e7b8bb3d6a",
"assets/assets/bilder/eye.svg": "0de80c5ba0189b20bf0b0ab499cce5d4",
"assets/assets/bilder/google.png": "75c8884ad3854429c081ef5c2bed6612",
"assets/assets/bilder/googleg.png": "2a0d85176c2920afc72f2a3c439eb270",
"assets/assets/bilder/GoogleG.svg": "edd0e34f60d7ca4a2f4ece79cff21ae3",
"assets/FontManifest.json": "c4cd1b5c4cbe78ddd870ed6cc09dcb94",
"assets/fonts/MaterialIcons-Regular.otf": "a09c3acff5f060a480aab630cb836bdf",
"assets/NOTICES": "18930c372d64b48274b5209b2187e578",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/flutter_3d_controller/assets/model_viewer.min.js": "11f3833db561a92ac9100cd43d28899b",
"assets/packages/flutter_3d_controller/assets/model_viewer_template.html": "d370dc1bc2b1dd29090c1946dbef646a",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "509ae636cfdd93e49b5a6eaf0f06d79f",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Brands-Regular-400.otf": "1fcba7a59e49001aa1b4409a25d425b0",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Regular-400.otf": "b2703f18eee8303425a5342dba6958db",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Solid-900.otf": "5b8d20acec3e57711717f61417c1be44",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf": "feec9ba4caf7d09c96eead27d7ad4d18",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded.ttf": "7ddd19649b4853e67c6c3dd160ebd030",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp.ttf": "f78c0d3b7dd9852b0c5506dd0b5ce45a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "e6764ef3b7c4b348d55e46ec178088a5",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "51a3a7bb29e826bb38b20bf3abecde57",
"/": "51a3a7bb29e826bb38b20bf3abecde57",
"main.dart.js": "df22082b0b69c64bf8dd0347d67a2580",
"manifest.json": "c443d55bb62b100401d77d00b183138a",
"version.json": "064136fe7527a575d836451276a9c0d7"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
