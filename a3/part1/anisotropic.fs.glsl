// Uniforms: 
uniform vec3 light_col;
uniform vec3 ambient;
uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;
uniform float alphaX;
uniform float alphaY;

// Varying attributes:
varying vec3 light_dir;
varying vec3 norm_new;
varying vec3 frag_pos;
varying vec3 camera_pos;

void main() {

  vec3 up = vec3(0.0, 1.0, 0.0);

  //AMBIENT
  vec3 light_AMB = ambient * kAmbient;


  //DIFFUSE
  float LN = dot(light_dir, norm_new);

  vec3 light_DFF = vec3(max(0.0, LN)) * light_col * kDiffuse;

  
  //SPECULAR
  vec3 view_vec = normalize(camera_pos - frag_pos);
  vec3 half_vec = normalize(light_dir + view_vec);
  vec3 tangent_vec = normalize(cross(norm_new, up));
  vec3 binormal_vec = normalize(cross(norm_new, tangent_vec));
  float VN = dot(view_vec, norm_new);

  // exponent = -2 * (((H dot T)/alphaX)^2 + ((H dot B)/alphay)^2) / (1 + H dot N)
 
    float exponent = -2.0 *
  (pow((dot(half_vec, tangent_vec)/alphaX), 2.0) + pow((dot(half_vec, binormal_vec)/alphaY), 2.0)) /
  (1.0 + dot(half_vec, norm_new));

 
  vec3 light_SPC = sqrt(max(0.0, LN/VN)) * exp(exponent) * light_col * kSpecular; 
  //TOTAL
  vec3 TOTAL = light_AMB + light_DFF + light_SPC;
  gl_FragColor = vec4(TOTAL, 0.0);

}