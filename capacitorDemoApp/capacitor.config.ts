import { CapacitorConfig } from "@capacitor/cli";
const config: CapacitorConfig = {
  appId: "com.metamap.capacitordemoapp",
  appName: "Photo Gallery Cap Ng",
  bundledWebRuntime: false,
  npmClient: "npm",
  webDir: "www",
  ios: {
    minVersion: "12.0",
  },
};

export default config;
