/// <reference types="node" />
/// <reference types="react" />
/// <reference types="react-dom" />

declare namespace NodeJS {
  interface ProcessEnv {
    readonly NODE_ENV: "development" | "production" | "test";
    readonly PUBLIC_URL: string;
  }
}

declare module "*.svg" {
  import * as React from "react";

  export const RC: React.FunctionComponent<
    React.SVGProps<SVGSVGElement> & { title?: string }
  >;

  const src: string;
  export default src;
}

declare module "pinch-zoom-js" {
  //   tapZoomFactor:      Zoom factor that a double tap zooms to. (default 2)
  // zoomOutFactor:      Resizes to original size when zoom factor is below this value. (default 1.3)
  // animationDuration:  Animation duration in milliseconds. (default 300)
  // maxZoom:            Maximum zoom factor. (default 4)
  // minZoom:            Minimum zoom factor. (default 0.5)
  // draggableUnzoomed:  Capture drag events even when the image isn't zoomed. (default true)
  //                     (using `false` allows other libs (e.g. swipe) to pick up drag events)
  // lockDragAxis:       Lock panning of the element to a single axis. (default false)
  // setOffsetsOnce:     Compute offsets (image position inside container) only once. (default false)
  //                     (using `true` maintains the offset on consecutive `load` and `resize`)
  // use2d:              Fall back to 2D transforms when idle. (default true)
  //                     (a truthy value will still use 3D transforms during animation)

  export default class PinchZoom {
    constructor(element: HTMLElement, options?: any);
    enable(): void;
    disable(): void;
    destroy(): void;
  }
}

// declare module "siwe" {
//   export class SiweMessage {
//     constructor(options: any);
//     prepareMessage(): string;
//   }
// }

// declare module "*.avif" {
//   const src: string;
//   export default src;
// }

// declare module "*.bmp" {
//   const src: string;
//   export default src;
// }

// declare module "*.gif" {
//   const src: string;
//   export default src;
// }

// declare module "*.jpg" {
//   const src: string;
//   export default src;
// }

// declare module "*.jpeg" {
//   const src: string;
//   export default src;
// }

// declare module "*.png" {
//   const src: string;
//   export default src;
// }

// declare module "*.webp" {
//   const src: string;
//   export default src;
// }

// declare module "*.module.css" {
//   const classes: { readonly [key: string]: string };
//   export default classes;
// }
