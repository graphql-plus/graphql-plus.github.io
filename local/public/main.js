import graphqlPlus from "./graphql-plus.js";
import peg from "./peg.js";

export default {
  configureHljs: function(hljs) {
    hljs.registerLanguage("peg", peg);
    hljs.registerLanguage("graphql-plus", graphqlPlus);
  }
};
