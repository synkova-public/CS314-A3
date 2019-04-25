// Uniforms: 
uniform vec3 light_col;
uniform vec3 ambient;
uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

// Varying attributes:
varying vec3 light_dir;
varying vec3 norm_new;
varying vec3 frag_pos;
varying vec3 camera_pos;

void main() {

  //AMBIENT
  vec3 light_AMB = ambient * kAmbient;

  float NL = dot(norm_new, light_dir);

  //DIFFUSE
  vec3 light_DFF = vec3(max(0.0, NL)) * light_col * kDiffuse;

  //SPECULAR
  vec3 view_vec = normalize(camera_pos - frag_pos);
  vec3 half_vec = normalize(light_dir + view_vec);
  vec3 light_SPC = vec3(pow(max(0.0, dot(half_vec, norm_new)), shininess)) * light_col * kSpecular;

  //TOTAL
  vec3 TOTAL = light_AMB + light_DFF + light_SPC;
  gl_FragColor = vec4(TOTAL, 0.0);

}