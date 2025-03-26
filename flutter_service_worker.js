'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "1c72917fb8e557bab5845196aeb47a97",
"version.json": "e8e09c423bb089f1f461d9620e4fe815",
"index.html": "7d4638d6db04c4e612c2e3c93916e7cf",
"/": "7d4638d6db04c4e612c2e3c93916e7cf",
"main.dart.js": "b9cc788277fa6dcefb732cd13cad6e26",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "85155d4a70584d18d6686001afc2164d",
".git/config": "34f4e49f7d6e163c3b09b20a71c69b83",
".git/objects/95/7fae1c8e29e52afa822542d91f658c14ecf2da": "2dc80d9e59209c7c64147f7baa0277d3",
".git/objects/0c/35557f894260bf56734502ed78cce11be7dd7c": "48d9b1e7d4f0ba5b62b69a93b992326f",
".git/objects/66/6c7a6837eae6c823c52a7c13a41484cb7c5015": "74470501125022e1cbbb71141780f2b5",
".git/objects/57/7946daf6467a3f0a883583abfb8f1e57c86b54": "846aff8094feabe0db132052fd10f62a",
".git/objects/57/9b829fe65bbd738437d7ddab6a2e1e97de598d": "5370dafdbd8fd4becb1c23dd0e1f57bb",
".git/objects/03/2fe904174b32b7135766696dd37e9a95c1b4fd": "80ba3eb567ab1b2327a13096a62dd17e",
".git/objects/03/eaddffb9c0e55fb7b5f9b378d9134d8d75dd37": "87850ce0a3dd72f458581004b58ac0d6",
".git/objects/9b/6adfbf004bf1a1d7ebc17e58cacdcff9f119bc": "282ae9b32801b9b4499315dd3ed25805",
".git/objects/9e/fbe4fa0c1248c5088a1aeb9865cec18c3db47d": "d5836a0571d7684a28c7c5062bdf0225",
".git/objects/9e/a42187acc44014239bd26cebb7f12ba713bb77": "909eba0af04bbab48bd6f6f0d8d35ff1",
".git/objects/35/96d08a5b8c249a9ff1eb36682aee2a23e61bac": "e931dda039902c600d4ba7d954ff090f",
".git/objects/69/dd618354fa4dade8a26e0fd18f5e87dd079236": "8cc17911af57a5f6dc0b9ee255bb1a93",
".git/objects/5f/bebe7fc3716a5fa38cc69127f600d6c568b240": "ae2e48d7652ba08b51dbdcf0504eb4ab",
".git/objects/5f/bf1f5ee49ba64ffa8e24e19c0231e22add1631": "f19d414bb2afb15ab9eb762fd11311d6",
".git/objects/a4/397da0a6a03393780ffa9832e4635a46882fd1": "93260ace5b46091df57da6bd4f83455b",
".git/objects/a3/438ec92ea85e0f6403ce59c547b8de2a300d4d": "3a4661e5d6e78c5762fe9de9f2a12d9f",
".git/objects/d9/3952e90f26e65356f31c60fc394efb26313167": "1401847c6f090e48e83740a00be1c303",
".git/objects/bb/27ae522fc3f110f56342d4dbdd4479c4153327": "6e57a93329cee16295dbd092c88348ed",
".git/objects/be/20690dbdc8f9f5a630ccd916b132dc8035926b": "5df5a5bd6cdeae8ca1f211907b933f79",
".git/objects/b4/9400667530b884e6754ac3aa5e37d64a66ef28": "e4f2a7ea6b8b5524f6424ecc4dd2631f",
".git/objects/a5/de584f4d25ef8aace1c5a0c190c3b31639895b": "9fbbb0db1824af504c56e5d959e1cdff",
".git/objects/bd/6be43d015a2a8a92db341ee519feb383a20cb4": "0df4c80430aff6e9b0cdd970bc215545",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/ab/0e98497a51ead7821d1da35a24968ff314e50f": "557c35fe3928eb2af403d1b3926bb9ba",
".git/objects/e5/951dfb943474a56e611d9923405cd06c2dd28d": "c6fa51103d8db5478e1a43a661f6c68d",
".git/objects/f4/005fa374aa26d2524125cd8ff1701706225ec5": "3ae1155d517701727c404c90b4723475",
".git/objects/f3/709a83aedf1f03d6e04459831b12355a9b9ef1": "538d2edfa707ca92ed0b867d6c3903d1",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/c7/7969e23e3dbe0c549ffb43f3a57c6e621c2a6d": "ebec458de1d3f33dd22fc7850b8f18ac",
".git/objects/c7/735e526a7e82c82e5c00c619f7d304cde9e1b2": "b57932e0aebc296b84cce00a220ac62f",
".git/objects/ee/64b3a467d5bb89c1bd1b89f9c585708025c36f": "3b47df5a5f9b6da3b635ff3471b15e7d",
".git/objects/fd/6a0e54fb501f46c1ae00ecea08405c03ae51eb": "8bd652b3cc91ebbc8400ca85e0228912",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f2/7ef753559cfbc53ba45693cee5a4e2dc302d7f": "93e8b393dfdb8732446e38fb0af88d96",
".git/objects/f5/61907ce732b7fc2993f14c75e8b8e7946b2b42": "38837ec662eab28f81fc3379dc9bfe78",
".git/objects/fe/8ff583204716cb2ef596c18c7276ef8e2a9ea7": "3b6641181440d491c1a25807d7dd5901",
".git/objects/c8/2d56ededce791c3ab111a4989af29c40946c4d": "df469e0889e8dcb4fa1e6a9bb4da09a1",
".git/objects/c6/e490eb48c84d2f228fd81c28027dc20bcdc972": "7187aa5fc28885f141f133e4f13c700e",
".git/objects/7d/d347040077cad2c32d7cd102c34eea6ca911db": "6082cacdc2b2bdf8961db266b3643dad",
".git/objects/1a/199196c20f62f43453c2a5297dd673da76fcdd": "7d589c95577146b5f686c79846d56324",
".git/objects/8f/6d3dcdf4c9f0a8602dd77946bbdc6e9c6f0d50": "11b58138c1ee0494419c2d413db539b3",
".git/objects/8f/e7af5a3e840b75b70e59c3ffda1b58e84a5a1c": "e3695ae5742d7e56a9c696f82745288d",
".git/objects/8f/b282b73a5d95c92476c28803ac8bc448dc0343": "166cd2b9daa35cbcc606339ac5e55638",
".git/objects/8a/51a9b155d31c44b148d7e287fc2872e0cafd42": "9f785032380d7569e69b3d17172f64e8",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/19/1aa704aa90ab3c3117270d4166a2f84100259c": "b6490b88d7c127482860b29389e6bcf6",
".git/objects/26/1c43ea7ffde836dec4d02503557edc61a7e53d": "975b178dd71a81eacb2b49c375e5d6f2",
".git/objects/2a/a1f83c636c2214128409317c448b7410b2b051": "0889d1822f7f95c085e2bf897c813fd5",
".git/objects/2f/48b1a1ab57fd48a2ee5cb6b7b7e80b4e8db6fd": "bc75e7d39e6ca6e788146b53f0c094fa",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/00/92ee7399263239148cb2e6ad98b625058a67e9": "4100ffe650ee2c2c5f1620268ae47bb7",
".git/objects/09/1e1e01d6df4f1f0bce60b99ce429c0a61c66e4": "dec4247bcc2e024aea7e24565e6c1697",
".git/objects/31/a2d4a492464d6a6c16c0f1e2c9025d6c2ff209": "7581d56ffd5dd99047e1acd9743e796b",
".git/objects/91/4a40ccb508c126fa995820d01ea15c69bb95f7": "8963a99a625c47f6cd41ba314ebd2488",
".git/objects/62/bcbffa43b11d0ef1c47fcf2e393cc8891194a5": "9f1cc1135334d56bd18f5c0b86b1ab62",
".git/objects/54/b57315f25f445211352b0bed458d431ae6900b": "92928e90cee47d4c003b800411f18f90",
".git/objects/30/96443ff41c9e6808b7a796e305f87ee5e55bc3": "985122ceee320ff062592d79446620ea",
".git/objects/5b/99514c7d83bef5368c7e8e572f21a2534a4495": "90ac82858bd887b24a1380bce92703bb",
".git/objects/5b/3af4414dba920fe2ddbe4210497df96653e05e": "b9a20cc7200ceb08ef8c6721dc36d078",
".git/objects/6d/3f6faba5e62136f3c6c6b14fbd1590cf6f72d2": "46d5b9c70e2f4640b8b2e5742e6cdff7",
".git/objects/06/3b361203eccdfec9a4a5c74c9ada9cf2391afd": "8d54be16d02c3cca7b4304789f108c44",
".git/objects/d3/9408f368b09d3f37384f42c0578874b1e74e59": "f77b217035cfa421e1f9e18b36aed935",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/a0/47c06579d669b2f365a6f950da4e05a3fac134": "d149b53a33e94bd96c11b2dfbd9d4ea4",
".git/objects/a7/629d9fa2a8394157f0dc6d45e85c9b2e100469": "96dda927ec3524bb59babc7aaa252300",
".git/objects/b8/c62e7c3719d09b9704bcf47a74d9a356f4adf4": "fb52e00996ed573ca2d3683ddbdab2d2",
".git/objects/dc/f83695f71da8c6278eb914cdd42692c427924e": "9ca7f32e12839dea4610032ada023058",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/db/1d973ae4511e7cf71f58dd756cad898cf74f8a": "a09bf87da2557063e78799f0c9b967b3",
".git/objects/a8/8c9340e408fca6e68e2d6cd8363dccc2bd8642": "11e9d76ebfeb0c92c8dff256819c0796",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/a1/3837a12450aceaa5c8e807c32e781831d67a8f": "bfe4910ea01eb3d69e9520c3b42a0adf",
".git/objects/ef/b875788e4094f6091d9caa43e35c77640aaf21": "27e32738aea45acd66b98d36fc9fc9e0",
".git/objects/ea/ebbb4c57b0713a1f0d35eaf76b8ad435655d70": "36f7f7edfc736a8676e6d208de1103bb",
".git/objects/ea/644298b14798dcd61f6382c82e37df240d49c6": "deae0cc79bc78c090817ff6b071c7128",
".git/objects/f0/2f52cf459329d3812b662e5f91dbda6110e6e6": "755f4cea985d11705480cefcdb4cbeed",
".git/objects/ff/66777ad3ef61769d5963cb92cd5799b20bd731": "20f00ebeb9ffcff7b9c9037aeae2955d",
".git/objects/c5/0ef14f7afd6aa3189b44fc8a349d0dffd74dce": "7887066a11760920bfef54a294ddf32d",
".git/objects/c2/7e93215a0cc8983a058a100dcd8af69ac6588a": "c82622e084c00547a210e483a629ddcd",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/2c/6788eb089cb73587f650ad405d3cd36a4dc1ce": "5a006abbcdc8389d24475784e9b1fb29",
".git/objects/79/ba7ea0836b93b3f178067bcd0a0945dbc26b3f": "f3e31aec622d6cf63f619aa3a6023103",
".git/objects/2d/c9fb835255e7de853138d3d1771b56f08b7042": "9b76988804da0cba3b5ad55ea6e48f30",
".git/objects/41/5c059c8094b888b0159fdedfd4e3cb08a8028e": "86914685ccd40e82a7fe5b70459fb9f7",
".git/objects/70/1bcc80771eb9aa49aca3b099e6c8d2b859722d": "bf52d01e2242b8dceac5efe1f571539a",
".git/objects/4a/a107050e781d77d105d0c2992d84e9c8febb7d": "2041119294e4d49c25a57b3e0916b921",
".git/objects/4a/e3ebf086bd4fa7508b7c1fdd503b0b927d78b5": "8a5244fc19f335b58cc773e834ed5083",
".git/objects/4f/5ba5d8e3c2efc11ba3dfbfdccdae8a28c4639b": "131d4f57cf28d9a15552d58959a0929d",
".git/objects/4f/02e9875cb698379e68a23ba5d25625e0e2e4bc": "254bc336602c9480c293f5f1c64bb4c7",
".git/objects/8c/99266130a89547b4344f47e08aacad473b14e0": "41375232ceba14f47b99f9d83708cb79",
".git/objects/8c/485602a4d664645813bd7fe3b68caa8ca17950": "dab4a7649f6be50dd26e3aab0a0557fe",
".git/objects/40/1184f2840fcfb39ffde5f2f82fe5957c37d6fa": "1ea653b99fd29cd15fcc068857a1dbb2",
".git/objects/2e/e6f3460c558c05a3a5e318220977a0f141d877": "e993d9f8e06de4605aed0f57dd2793b8",
".git/objects/2b/3b28c75191f42630d2e5616e70c69c5b51e177": "949af734f2eeb430156caca6c119d874",
".git/objects/47/044ee97300fd799a98663a90c58c2a651d77f8": "9066b868286c2d240cde0d2a8ba04b67",
".git/objects/7a/cad09656fb4f9e3b4e656562df4da203b9422f": "948c53499ae62069c14dd8cd43b718ba",
".git/objects/25/b5f27180f0d4d8231509095353abe60607f621": "85d035fa729bc87b273b8bc52c8a9716",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "f764cd7311b52e5eade33ca0be2d0477",
".git/logs/refs/heads/main": "458899b97f933eb49fa192bcfa16fdc2",
".git/logs/refs/remotes/origin/main": "4c3911e22a128e9d5a0fd9157abae21b",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/main": "ae93ea4a39b62c4e13160c4adfa0a293",
".git/refs/remotes/origin/main": "ae93ea4a39b62c4e13160c4adfa0a293",
".git/index": "51afc07bc03e749bc945a48051fbaa4d",
".git/COMMIT_EDITMSG": "8c27458f47e6c75da578266800b4e0f2",
"assets/AssetManifest.json": "2efbb41d7877d10aac9d091f58ccd7b9",
"assets/NOTICES": "ed62e872a15a5c98c5442e6ca9ebc32b",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "69a99f98c8b1fb8111c5fb961769fcd8",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "693635b5258fe5f1cda720cf224f158c",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
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
