uniform vec3 light_col;
varying vec3 light_dir;
varying vec3 norm_new;
uniform vec3 ambient;
uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;
varying vec3 frag_pos;
varying vec3 camera_pos;

void main() {

  //AMBIENT
  vec3 light_AMB = ambient * kAmbient;

  float NL = dot(light_dir, norm_new);

  //DIFFUSE
  vec3 light_DFF = vec3(max(0.0, NL)) * light_col * kDiffuse;

  //SPECULAR
  vec3 bounce_vec = normalize(-light_dir + (2.0 * NL * norm_new));
  vec3 view_vec = normalize(camera_pos - frag_pos);
  vec3 light_SPC = vec3(pow(max(0.0, dot(bounce_vec, view_vec)), shininess)) * light_col * kSpecular;

  //TOTAL
  vec3 TOTAL = light_AMB + light_DFF + light_SPC;

  float lightIntensity = length(TOTAL);
  vec4 resultingColor;

  // quantize
  if(lightIntensity > 1.6) {
    resultingColor = vec4(0.8, 0.1, 0.0, 0.0);
  } else if(lightIntensity > 1.5){
    resultingColor = vec4(1.0, 0.0, 0.0, 0.0);
  } else if(lightIntensity > 1.4){
    resultingColor = vec4(1.0, 0.2, 0.0, 0.0);
  } else if(lightIntensity > 1.3){
    resultingColor = vec4(1.0, 0.4, 0.0, 0.0);
  } else if(lightIntensity > 1.2) {
    resultingColor = vec4(1.0, 0.6, 0.0, 0.0);
  } else if(lightIntensity > 1.1) {
    resultingColor = vec4(1.0, 0.8, 0.0, 0.0);
  } else if(lightIntensity > 1.0) {
    resultingColor = vec4(1.0, 1.0, 0.0, 0.0);
  } else if(lightIntensity > 0.9) {
    resultingColor = vec4(0.7, 1.0, 0.0, 0.0);
  } else if(lightIntensity > 0.8) {
    resultingColor = vec4(0.4, 1.0, 0.0, 0.0);
  } else if(lightIntensity > 0.7) {
    resultingColor = vec4(0.0, 1.0, 0.0, 0.0);
  } else if(lightIntensity > 0.6) {
    resultingColor = vec4(0.0, 1.0, 0.5, 0.0);
  } else if(lightIntensity > 0.5) {
    resultingColor = vec4(0.0, 0.8, 0.6, 0.0);
  } else if(lightIntensity > 0.4) {
    resultingColor = vec4(0.0, 0.3, 0.8, 0.0);
  } else if(lightIntensity > 0.2) {
    resultingColor = vec4(0.0, 0.0, 1.0, 0.0);
  }

  // silhouette objects

  float NV = dot(norm_new, view_vec);
  if(NV > -0.1 && NV < 0.1) {
    resultingColor = vec4(1.0, 1.0, 1.0, 0.0);
  }

  gl_FragColor = resultingColor;
}