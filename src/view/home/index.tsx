import { Button } from 'antd';
// export const IS_PROD = process.env.IS_PROD;
// const appendMasterJs = () => {
//   // @ts-ignore
//   window.__PLATFORM = 'web';
//   if (!document.getElementById('wai_root')) {
//     const divElement = document.createElement('div');
//     divElement.id = 'wai_root';
//     document.body.appendChild(divElement);
//     console.log('[WAI] created div#wai_root!');
//   }
//   if (!document.getElementById('bundle')) {
//     const script = document.createElement('script');
//     if (!IS_PROD) {
//       script.src = 'http://localhost:3100/static/wai-chat-bot/bundle.js';
//     } else {
//       script.src = 'app/static/wai-chat-bot/bundle.js';
//     }
//
//     script.id = 'bundle';
//     document.head.appendChild(script);
//     console.log('[WAI] append ' + script.src, 'IS_PROD:', IS_PROD);
//   }
// };
export default function Home() {
  // appendMasterJs()
  return (
    <div
      style={{
        height: '100vh',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'space-around',
      }}
    >
      <Button
        type="primary"
        onClick={(e) => {
          setTimeout(async () => {}, 1000);
        }}
      >
        InvokeRpaApi
      </Button>
    </div>
  );
}
